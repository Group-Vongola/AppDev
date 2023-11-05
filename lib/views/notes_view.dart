import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/enums/menu_action.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main User Interface'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async{
              switch(value){
                case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if(shouldLogout){
                  await AuthService.firebase().logOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute, 
                    (route) => false
                  );
                }
              }

          },itemBuilder: (context){
            return [ 
              const PopupMenuItem<MenuAction>(
              //what programmer see
              value: MenuAction.logout,
              //what user see
              child: Text('log out'),
              ),
            ];
          },
          )
        ]
      ),
      body: const Text('Hello world')
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          //Cancel button
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(false);
            }, 
            child: const Text('Cancel')),
          //Logout button
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(true);
            }, 
            child: const Text('Log out')),
        ],
      );
    }
  ).then((value) => value ?? false);
}