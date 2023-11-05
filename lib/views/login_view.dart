import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/services/auth/auth_exceptions.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/utilities/show_error_dialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //late = wait for later input
  late final TextEditingController _email;
  late final TextEditingController _password;

@override
  void initState() {
    _email = TextEditingController();
    _password =TextEditingController();
    super.initState();
  }

@override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //scaffold to create the appbar
    return Scaffold(
      appBar: AppBar(
        title:const Text('Login'),
      ),
      body: Column(
       children: [
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Enter your email here',
          ),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Enter your password here',
          ),
        ),
        TextButton(
          onPressed: () async { 
            final email = _email.text;
            final password = _password.text;
            try{
              //login through email and password
              await AuthService.firebase().logIn(
                email: email, 
                password: password,
              );
              final user = AuthService.firebase().currentUser;
              if(user?.isEmailVerified??false){
                //user's email is verified
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(
                notesRoute, 
                (route) => false,
              );
              }else{
                //user's email is not verified
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(
                verifyEmailRoute, 
                (route) => false,
              );
              }
            } on UserNotFoundAuthException {
                // ignore: use_build_context_synchronously
                await showErrorDialog(
                  context, 
                  'User not found. Please ensure you enter correct email and password',
                );
            } on GenericAuthException{
                // ignore: use_build_context_synchronously
                await showErrorDialog(
                  context, 
                  'Authentication error',
                );
            }
          }, 
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: (){
              //on pressed, will lead to register page
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute, 
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register here!'),
          )
        ],
      ),
    );
  }
}

