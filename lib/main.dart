import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';

import 'package:flutter_application_1/views/login_view.dart';
import 'package:flutter_application_1/views/notes/create_update_note_view.dart';
import 'package:flutter_application_1/views/notes/notes_view.dart';
import 'package:flutter_application_1/views/register_view.dart';
import 'package:flutter_application_1/views/verify_email.dart';
//import 'dart:developer' as devtools show log;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
      //navigate between login and register
      routes: {
        loginRoute:(context) => const LoginView(),
        registerRoute:(context) => const RegisterView(),
        notesRoute:(context) => const NotesView(),
        verifyEmailRoute:(context) => const VerifyEmailView(),
        createOrUpdateNoteRoute:(context) => const CreateUpdateNoteView(),
      },
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          //loading page
          switch(snapshot.connectionState){
            //when completed
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if(user != null){
                //if the user is registered
                if(user.isEmailVerified){
                  //return scaffold in notesview
                  return const NotesView();
                } else{
                  return const VerifyEmailView();
                }
              }else{
                //if have not register as an user
                return const LoginView();
              }
              
            default:
              return const CircularProgressIndicator();
          }
        },
      
    );
  }
}
