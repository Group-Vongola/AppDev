import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/crud/notes_service.dart';
import 'package:flutter_application_1/utilities/dialogs/delete_dialog.dart';

//define function of call back
typedef DeleteNoteCallBack = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {

  final List<DatabaseNote> notes;
  final DeleteNoteCallBack onDeleteNote;

  const NotesListView({
    super.key, 
    required this.notes, 
    required this.onDeleteNote
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index){
      final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            //to wrap information, show there is more to be rendered
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          //specify widget to be displayed a the end of list tile
          trailing: IconButton(
            onPressed: () async{
              final shouldDelete = await showDeleteDialog(context);
              if(shouldDelete){
                onDeleteNote(note);
              }
            }, 
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}