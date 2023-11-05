import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text("We've sent you an ermail verfication. Please open it to verify your account."),
          const Text("If you haven't received a verification email yet, press the buttonn below"),
          TextButton(
          onPressed: () async{
            AuthService.firebase().sendEmailVerification();
          },
          child: const Text('Send email verification'),
          ),
          TextButton(
            onPressed:() async{
              await AuthService.firebase().logOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute, 
                (route) => false,
              );
            }, 
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }
}

