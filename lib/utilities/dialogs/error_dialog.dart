import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
){
  return showGenericDialog(
    context: context, 
    title: 'An error occurred', 
    content: text, 
    //function that return map
    optionBuilder: () => {
      //key with ok with value of null
      'OK': null,
    },
  );
}