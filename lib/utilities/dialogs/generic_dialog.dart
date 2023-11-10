import 'package:flutter/material.dart';

//Map<String, T?> -> list of title to display on every button, match the title(string)
//with the value(T), 
typedef DialogOptionBuilder<T> = Map<String, T?> Function(); 


//'T' -> dynamic
Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder,
}) {
  final options = optionBuilder();
  return showDialog<T>(
    context: context, 
    builder: (context){
      return AlertDialog(
        title:Text(title),
        content: Text(content),
        //every key in map is optiontitle(title on button)
        actions: options.keys.map((optionTitle){
          //title is mapped to the text button
          final T value = options[optionTitle];
          return TextButton(
            onPressed: (){
              if(value != null){
                
                Navigator.of(context).pop(value);
              }else{
                //ok button with null
                Navigator.of(context).pop();
              }
            }, 
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );

}