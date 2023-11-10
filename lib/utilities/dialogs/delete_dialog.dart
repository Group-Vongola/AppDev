import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dialogs/generic_dialog.dart';

Future<bool>showDeleteDialog(BuildContext context){
  return showGenericDialog<bool>(
    context: context, 
    title: 'Delete', 
    content: 'Are you sure you want to delete this item?', 
    optionBuilder: () => {
      'Cancel': false,
      'Yes': true,
    },
  ).then(
    //either return value or return false
    (value) => value ?? false,
  );
}