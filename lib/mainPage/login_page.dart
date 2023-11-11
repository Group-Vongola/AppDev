import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/services/auth/auth_exceptions.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/utilities/dialogs/error_dialog.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: const Color.fromARGB(255, 175, 219, 255),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), 
          onPressed: () { 
            Navigator.of(context).pushNamedAndRemoveUntil(
              welcomeRoute, 
              (route) => false,
            );
          },
        ),
      ),
      body: Container(
        //create the margin in left and right
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: 
        Padding(
          padding: const EdgeInsets.only(top:50),
          child: Container(
            color: Colors.white,
            height: 500,
            child: Form(
              key: _formkey,
              child: Column(
                //evenly space between items
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //to move all items to center
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 170),
                    child: Text(
                      'Login', 
                      style: TextStyle(
                        color:Colors.black, 
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: 'Enter your email here',
                          focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black),
                            borderRadius: new BorderRadius.circular(20),
                          ),
                          //draw underline
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black),
                            borderRadius: new BorderRadius.circular(20),
                          ),
                        ),
                        validator:(value) {
                          if(value!.isEmpty){
                            return "Email cannot be empty";
                          }
                          else{
                            return null;
                          }
                        },
                        onChanged: (value){},
                      ),
                      
                      //to adjust space between two text field
                      const SizedBox(height: 20,),
            
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        obscureText: _isObscure,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: 'Enter your password here',
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        //draw underline
                          enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        ),
                          validator: (value) {
                          if(value!.isEmpty){
                            return "password cannot be empty";
                          }
                          else{
                            return null;
                          }
                        },
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  SizedBox(
                    //height and width of button
                    height: 50,
                    width: 170,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //change the color of button
                        backgroundColor: Colors.amber,
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
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                      onPressed: () async { 
                        if(_formkey.currentState!.validate()){
                          try{
                            await AuthService.firebase().logIn(
                              email: emailController.text, 
                              password: passwordController.text,
                            );
                            
                            final user = AuthService.firebase().currentUser!;
                            final userId = user.id;
                            if(user?.isEmailVerified??false){
                              await FirebaseFirestore.instance.collection('users')
                              .doc()
                              .get()
                              .then((DocumentSnapshot documentSnapshot) async {
                                
                                if(documentSnapshot.exists){
                                  
                                  if(documentSnapshot.get('role') == "Business owner"){
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        businessOwnerRoute, 
                                        (route) => false,
                                    );
                                  }
                                  else if(documentSnapshot.get('role') == "Customer"){
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        customerRoute, 
                                        (route) => false,
                                    );
                                  }else if(documentSnapshot.get('role') == "Delivery man"){
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        deliveryManOwnerRoute, 
                                        (route) => false,
                                    );
                                  }
                                  else{
                                    await showErrorDialog(
                                      context, 
                                      'Invalid account',
                                    );
                                  }
                                }else{
                                  await showErrorDialog(
                                    context, 
                                    'Document does not exist',
                                  );
                                }
                              });
                            }else{
                              //user's email is not verified
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyEmailRoute, 
                              (route) => false,
                            );
                            }
                          }on UserNotFoundAuthException {
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
                        }
                      }, 
                    ),           
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    TextButton(
                      onPressed: (){
                        //on pressed, will lead to register page
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute, 
                          (route) => false,
                        );
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states){
                            if(states.contains(MaterialState.hovered))
                              return const Color.fromARGB(255, 249, 201, 29);
                            return const Color.fromARGB(255, 79, 79, 79);
                          }
                        ),
                      ),
                      child: const Text('Not registered yet? Register here!',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
