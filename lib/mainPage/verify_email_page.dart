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
      backgroundColor: const Color.fromARGB(255, 175, 219, 255),
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const Text(
            'Email Verification',
            style: TextStyle(
              color:Colors.black, 
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            color: Colors.white,
            height: 340,
            width: 300,
            margin: EdgeInsets.fromLTRB(50,50,50,0),
            child: 
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Note:\nAn email verfication has been sent to your email. \nPlease open it to verify your account.",
                          style: TextStyle(fontSize: 18),
                    ),
                           
                    const Text("\nPress the button below to resend email verification.",
                          style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20,40,20,20),
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            //change the color of button
                            backgroundColor: Color.fromARGB(255, 240, 145, 3),                         //change the border to rounded side
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            //construct shadow color
                            elevation: 10,
                            shadowColor: const Color.fromARGB(255, 92, 90, 85),
                          ).copyWith(
                            //change color onpressed
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {  
                                if (states.contains(MaterialState.pressed))
                                  return Colors.blue;
                                  return null; // Defer to the widget's default.
                              }),
                          ),
                          onPressed: () async{
                            AuthService.firebase().sendEmailVerification();
                          }, 
                          child: const Text('Resend email verification'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //change the color of button
                  backgroundColor: Colors.grey,
                  //change the border to rounded side
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  //construct shadow color
                  elevation: 10,
                  shadowColor: const Color.fromARGB(255, 92, 90, 85),
                ).copyWith(
                  //change color onpressed
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {  
                      if (states.contains(MaterialState.pressed))
                        return Colors.blue;
                        return null; // Defer to the widget's default.
                    }),
                ),
                onPressed: () async{
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute, (route) => false,
                    );
                }, 
                child: const Text('Back to register page'),
            ),
          ),
        ],
      ),
    );
  }
}

// const Text("We've sent you an email verfication. Please open it to verify your account."),
//           const Text("If you haven't received a verification email yet, press the buttonn below"),
//           TextButton(
//           onPressed: () async{
//             AuthService.firebase().sendEmailVerification();
//           },
//           child: const Text('Send email verification'),
//           ),
//           TextButton(
//             onPressed:() async{
//               await AuthService.firebase().logOut();
//               // ignore: use_build_context_synchronously
//               Navigator.of(context).pushNamedAndRemoveUntil(
//                 registerRoute, 
//                 (route) => false,
//               );
//             }, 
//             child: const Text('Restart'),
//           )
