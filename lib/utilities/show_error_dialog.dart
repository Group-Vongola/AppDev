import 'package:flutter/material.dart';

Future<void> showErrorDialog (
  BuildContext context,
  String text,
  ){
    return showDialog(
      context: context, 
      builder: (context){
      return AlertDialog(
        //this is the title on top of the dialog box
        title: const Text('An error occurred'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: (){
              //dismiss the current dialog
              Navigator.of(context).pop();
            }, 
            child: const Text('OK'),
          ),
        ],
      );
    },
    );
  }