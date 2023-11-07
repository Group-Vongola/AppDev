import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/services/auth/auth_exceptions.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                //initial sign up/register
                await AuthService.firebase().createUser(
                  email: email, 
                  password: password
                );
                AuthService.firebase().sendEmailVerification();
                
                //pushNamed->will not replace the page to new page, just appear on it
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamed(verifyEmailRoute);
              }on WeakPasswordAuthException{
                // ignore: use_build_context_synchronously
                await showErrorDialog(
                    context, 
                    'Weak password'
                  );
              }on EmailAlreadyInUseAuthException{
                // ignore: use_build_context_synchronously
                await showErrorDialog(
                    context, 
                    'Email is already in use'
                  );
              }on InvalidEmailAuthException{
                // ignore: use_build_context_synchronously
                await showErrorDialog(
                    context, 
                    'invalid email entered'
                  );
              }on GenericAuthException{
                // ignore: use_build_context_synchronously
                await showErrorDialog(
                    context, 
                  'Failed to register',
                );
              }
            }, 
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: (){
              //on pressed will navigate to login page
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute, 
                (route) => false,
              );
            }, child: const Text('Already registered? Login here!'),
          ),
        ],
      ),
    );
  }
}