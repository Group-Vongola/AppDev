
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/services/cloud/cloud_note.dart';
import 'package:flutter_application_1/services/cloud/cloud_storage_constants.dart';
import 'package:flutter_application_1/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage{
  //grab note from firebase storage, from the collection called 'notes'
  final notes = FirebaseFirestore.instance.collection('notes');

  //delete note
  Future<void> deleteNote({required String documentId}) async {
    try{
      await notes.doc(documentId).delete();
    }catch (e){
      throw CouldNotDeleteNoteException();
    }
  }

  //update exisitng note
  Future<void>updateNote({
    required String documentId,
    required String text
  })async{
    try{
      //documentId is the path to update the text of the user in database
      await notes.doc(documentId).update({textFieldName: text});
    }catch (e){
      throw CouldNotUpdateNoteException();
    }
  }

  //get the users' all notes
  Stream<Iterable<CloudNote>>allNotes({required String ownerUserId}) =>
    notes.snapshots().map((event) => event.docs
      .map((doc) => CloudNote.fromSnapshot(doc))        //grab all notes  in database
      .where((note) => note.ownerUserId == ownerUserId) //to indicate current user
    );

  Future<Iterable<CloudNote>>getNotes({required String ownerUserId}) async{
    try {
      //search for all notes for the ownerUserId
      return await notes.where(
        ownerUserIdFieldName,
        isEqualTo: (ownerUserId),
      ).get()
      .then((value) => value.docs.map(
        (doc) {
          return CloudNote(
            documentId: doc.id, 
            ownerUserId: doc.data()[ownerUserIdFieldName] as String, 
            text: doc.data()[textFieldName] as String,
          );
        },
      ));

    }catch(e){
      throw CouldNotGetAllNotesException();
    }
    
  }

  void createdNewNote({required String ownerUserId}) async{
    await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });
  }


  static final FirebaseCloudStorage _shared = FirebaseCloudStorage._sharedInstance();

  //private constructor
  FirebaseCloudStorage._sharedInstance();
  //default constructor link to static final above
  factory FirebaseCloudStorage() => _shared;

}