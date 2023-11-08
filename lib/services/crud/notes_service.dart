//create, update, delete notes in the user interface

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/filter.dart';
import 'package:flutter_application_1/services/crud/crud_crudexceptions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'show join;
import 'package:path_provider/path_provider.dart';


class NotesService{
  Database? _db;

  List<DatabaseNote> _notes = [];

  //keep hold on user
  DatabaseUser? _user;

  //make note service a singleton
  static final NotesService _shared = NotesService._sharedInstance();


  NotesService._sharedInstance(){
    _notesStreamController = StreamController<List<DatabaseNote>>.broadcast(
      //populate note in stream controller
      onListen: (){
        _notesStreamController.sink.add(_notes);
      },
    );
  }
  
  //factory contstructor
  factory NotesService() => _shared;

  //listen to the changes, from outside
  late final StreamController<List<DatabaseNote>> _notesStreamController;

  //get all notes
  Stream<List<DatabaseNote>> get allNotes => 
    _notesStreamController.stream.filter((note) {
      final currentUser = _user;
      if(currentUser != null){
        return note.userId == currentUser.id;
      }else{
        throw UserShouldBeSetBeforeReadingAllNotes();
      }
    });

  //get or create user
  Future<DatabaseUser> getOrCreateUser({
    required String email,
    bool setAsCurrentUser = true,
    }) async{
    try{
      final user = await getUser(email: email);
      if(setAsCurrentUser){
        _user = user;
      }
      return user;
    }on CouldNotFindUser{
      final createdUser = await createUser(email: email);
      if(setAsCurrentUser){
        _user = createdUser;
      }
      return createdUser;
    }catch (e){
      rethrow;
    }
  }

  //the prefix(underscore, '_') shows the private function must be used in the class
  Future<void> _cacheNotes() async{
    final allNotes = await getAllNotes();  //read all notes
    _notes = allNotes.toList();            //put in local variable
    _notesStreamController.add(_notes);    //populate in stream controller
  }

  //ensure db is open
  Future<void> _ensureDbIsOpen() async{
    try{
      await open();
    }on DatabaseAlreadyOpenException{
      //empty
    }
  }

  //get current db
  Database _getDatabaseOrThrow(){
    final db = _db;
    if(db == null){
      throw DatabaseIsNotOpen();
    }else{
      return db;
    }
  }

  //close opened database
  Future<void> close () async{
    final db = _db;
    if(db == null){
      throw DatabaseIsNotOpen();
    }else{
      await db.close();
      _db = null;
    }
  }

  //open database
  Future<void> open() async{
    if(_db != null){
      throw DatabaseAlreadyOpenException();
    }
    try{
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

      //create user table if not exist
      await db.execute(createUserTable);

      //create user table if not exist
      await db.execute(createNoteTable);

      //read all notes
      await _cacheNotes();

    }on MissingPlatformDirectoryException{
      throw UnableToGetDocumentsDirectory();
    }
  }


  //to get user
  Future<DatabaseUser> getUser({required String email}) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable, 
      limit:1, 
      where:'email = ?', 
      whereArgs: [email.toLowerCase()],
    );
    if(results.isEmpty){
      throw CouldNotFindUser();
    }else{
      //start from first row
      return DatabaseUser.fromRow(results.first);
    }
  }

  //create new user
  Future<DatabaseUser> createUser({required String email}) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final results = await db.query(
      userTable, 
      limit:1, 
      where:'email = ?', 
      whereArgs: [email.toLowerCase()],
    );
    if(results.isNotEmpty){
      throw UserAlreadyExists();
    }

    final userId = await db.insert(userTable, {
      emailColumn : email.toLowerCase(),
    });

    return DatabaseUser(
      id:userId, 
      email:email
    );
  
  }

  //delete user
  Future<void> deleteUser({required String email}) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      userTable, where: 'email=?',
      whereArgs:[email.toLowerCase()],
    );
    //delete account is 0, means false, can not delete that user
    if(deletedCount != 1){
      throw CouldNotDeleteUser();
    }
  }

  
  //create notes for each user
  Future<DatabaseNote> createNote({required DatabaseUser owner}) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();

    //make sure onwer exits in database with correct id
    final dbUser = await getUser(email:owner.email);
    if(dbUser != owner){
      throw CouldNotFindUser();
    }

    const text = '';

    //create note, future item
    final noteId = await db.insert(noteTable, {
      userIdColumn: owner.id,
      textColumn: text,
      isSyncedWithCloudColumn: 1
    });

    final note = DatabaseNote(
      id: noteId, 
      userId: owner.id, 
      text: text, 
      isSyncedWithCloud: true
    );

    //add to array of note and stream controller
    _notes.add(note);

    //reflect the value inside underscore nodes to outside world
    _notesStreamController.add(_notes);

    return note;
  }

  //get all notes
  Future<Iterable<DatabaseNote>> getAllNotes() async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final notes = await db.query(
      noteTable, 
    );
    return notes.map((noteRow) => DatabaseNote.fromRow(noteRow));
  }

  //get specific note
  Future<DatabaseNote> getNote({required int id}) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final notes = await db.query(
      //from where
      noteTable, 
      //conditions
      limit: 1, 
      where: 'id = ?', 
      whereArgs: [id],
    );
    if(notes.isEmpty){
      throw CouldNotFindNote();
    }else{
      final note = DatabaseNote.fromRow(notes.first);
      //remove old note with same id
      _notes.removeWhere((note) => note.id == id);
      //add new note
      _notes.add(note);
      //update stream controller
      _notesStreamController.add(_notes);
      return note;
    }
  }

  //update existing note
  Future<DatabaseNote> updateNote({required DatabaseNote note, required String text}) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    //make sure note exist
    await getNote(id: note.id);

    //update database
    final updatesCount = await db.update(
      noteTable, {
        textColumn: text,
        isSyncedWithCloudColumn: 0, //not yet sync with cloud
      },
      where: 'id = ?',
      whereArgs: [note.id],
    );

    if(updatesCount == 0){
      throw CouldNotUpdateNote();
    }else{
      final updatedNote = await getNote(id: note.id);
      //remove note where note id= updated note id
      _notes.removeWhere((note) => note.id == updatedNote.id);
      _notes.add(updatedNote);
      _notesStreamController.add(_notes);
      return updatedNote;
    }
  }

  //delete all node
  Future<int>deleteAllNotes() async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final numberOfDeletions = await db.delete(noteTable); //return num of deleted notes
    //reset notes to empty
    _notes = [];
    //update stream controller
    _notesStreamController.add(_notes);
    return numberOfDeletions;
  }

  //delete note
  Future<void> deleteNote({required int id}) async{
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final deletedCount = await db.delete(
      //from the note table
      noteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if(deletedCount == 0){
      throw CouldNotDeleteNote();
    }else{
      //remove note from local cache
      _notes.removeWhere((note) => note.id == id);
      _notesStreamController.add(_notes);
    }


  }

  
}


@immutable
class DatabaseUser {
  final int id;
  final String email;
  const DatabaseUser({
    required this.id, 
    required this.email,
  });

  DatabaseUser.fromRow(Map<String, Object?>map): 
  id=map[idColumn] as int, 
  email=map[emailColumn] as String;


  @override
  String toString() => 'Person, ID =$id, email = $email';
  
  @override  //compare with database user instances
  bool operator == (covariant DatabaseUser other) => id == other.id;
  
  @override
  int get hashCode => id.hashCode;
  
}

class DatabaseNote{
  final int id;
  final int userId;
  final String text;
  final bool isSyncedWithCloud;

  DatabaseNote({
    required this.id, 
    required this.userId, 
    required this.text, 
    required this.isSyncedWithCloud,
  });

  DatabaseNote.fromRow(Map<String, Object?>map): 
  id=map[idColumn] as int, 
  userId=map[userIdColumn] as int,
  text=map[textColumn] as String,
  isSyncedWithCloud=
    (map[isSyncedWithCloudColumn] as int) == 1 ? true :false;   //if equal to 1, isSyncedWithCloud = true, else = false

  @override
  String toString() => 'Note, ID = $id, userId = $userId, isSyncedWithCloud = $isSyncedWithCloud, text = $text';

  @override  //compare with database user instances
  bool operator == (covariant DatabaseNote other) => id == other.id;
  
  @override
  int get hashCode => id.hashCode;

}

const dbName = 'notes.db';
const noteTable = 'note';
const userTable = 'user';
const idColumn ='id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn = 'text';
const isSyncedWithCloudColumn = 'is_synced_with_cloud';
const createUserTable = '''CREATE TABLE IF NOT EXISTS "user" (
  "id"	INTEGER NOT NULL,
  "email"	TEXT NOT NULL UNIQUE,
  PRIMARY KEY("id" AUTOINCREMENT)
);''';
const createNoteTable = '''CREATE TABLE IF NOT EXISTS "note" (
  "id"	INTEGER NOT NULL,
  "user_id"	INTEGER NOT NULL,
  "text"	TEXT,
  "is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY("user_id") REFERENCES "user"("id"),
  PRIMARY KEY("id" AUTOINCREMENT)
);''';