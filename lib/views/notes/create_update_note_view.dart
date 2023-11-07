import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/services/crud/notes_service.dart';
import 'package:flutter_application_1/utilities/generics/get_arguments.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  //'?'->optional
  DatabaseNote? _note;
  late final NotesService _notesService;
  late final TextEditingController _textController;

  //initial the status
  @override
  void initState(){
    _notesService = NotesService();
    _textController = TextEditingController();
    super.initState();
  }

  Future<DatabaseNote>createOrGetExistingNote(BuildContext context) async{

    final widgetNote = context.getArgument<DatabaseNote>();
    if(widgetNote != null){
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }


    final existingNote = _note;
    if(existingNote != null){
      return existingNote;
    }
    //'! -> explicitly unwrapped or optional'
    //to find the current existing user
    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email!;
    final owner = await _notesService.getUser(email: email);
    final newNote = await _notesService.createNote(owner: owner);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty(){
    final note = _note;
    //delete note if it is empty
    if(_textController.text.isEmpty && note != null){
      _notesService.deleteNote(id: note.id);
    }
  }

  //update automatically
  void _saveNoteIfTextNoEmpty() async {
    final note = _note;
    final text = _textController.text;
    if(note != null && text.isNotEmpty){
      await _notesService.updateNote(
        note: note, 
        text: text
      );
    }
  }

  @override
  void dispose(){
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNoEmpty();
    _textController.dispose();
    super.dispose();
  }

  //update current note upon text changes
  void _textControllerListener() async {
    final note = _note;
    if(note == null){
      return;
    }
    final text = _textController.text;
    await _notesService.updateNote(
      note: note, 
      text: text,
    );
  }
  
  //add listener if listener not exist
  void _setupTextControllerListener(){
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(context), 
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              //_note = snapshot.data as DatabaseNote;
              //listen to text changes
              _setupTextControllerListener();
              return TextField(
                controller: _textController,
                //enter multiple lines of text field
                keyboardType: TextInputType.multiline,
                //expand linespace
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Start typing your note...',
                ),
              );
            default: //when not done
              return const CircularProgressIndicator();
          }
        }
      )
    );
  }
}