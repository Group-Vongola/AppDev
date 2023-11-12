import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/services/auth/auth_exceptions.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/utilities/dialogs/error_dialog.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterView();
}

class _RegisterView extends State<Register>{
  //late = wait for later input
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool _isObscure = true;
  bool showProgress = false;
  
  var options = [
    'Business owner',
    'Customer',
    'Delivery man',
  ];
  var _currentItemSelected = 'Business owner';
  var role = 'Business owner';
    
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            color: Colors.white,
            height: 550,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color:Colors.black, 
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 300,
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: firstNameController,
                            decoration: InputDecoration(
                              hintText: 'firstName',
                              contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0
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
                            validator:(value) {
                              if(value!.isEmpty){
                                return "firstName cannot be empty";
                              }
                              else{
                                return null;
                              }
                            },
                            onChanged: (value){
                              
                            },
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: lastNameController,
                            decoration: InputDecoration(
                              hintText: 'lastName',
                              contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0
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
                            validator:(value) {
                              if(value!.isEmpty){
                                return "lastName cannot be empty";
                              }
                              else{
                                return null;
                              }
                            },
                            onChanged: (value){},
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'email',
                              contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0
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
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: passwordController,
                            obscureText: _isObscure,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
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
                              
                              hintText: 'password',
                              contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0
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
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Role : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 204, 200, 200), 
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.blue[200],
                          isDense: true,
                          isExpanded: false,
                          iconEnabledColor: Colors.black,
                          focusColor: Colors.black,
                          items: options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            setState(() {
                              _currentItemSelected = newValueSelected!;
                              role = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          //margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                            onPressed: () async { 
                              final email = emailController.text;
                              final password = passwordController.text;
                              final fName = firstNameController.text;
                              final lName = lastNameController.text;
                              if(_formkey.currentState!.validate()) {
                                await AuthService.firebase().createUser(email: email, password: password)
                                .then((value) => postDetailsToFirestore(fName, lName, email, role));
                              }
                              try{
                                //initial sign up/register
                                setState(() {
                                  showProgress = true;
                                });
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
                                    'Invalid email entered'
                                  );
                              }on GenericAuthException{
                                // ignore: use_build_context_synchronously
                                await showErrorDialog(
                                    context, 
                                  'Failed to register',
                                );
                              }
                            }, 
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: (){
                          //on pressed, will lead to register page
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, 
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
                        child: const Text('Already registered? Login here!',
                          style: TextStyle(
                          decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ), 
      )
    );
  }
}

void postDetailsToFirestore(String fName, String lName, String email, String role) async{
  final currentUser = AuthService.firebase().currentUser!;
  final userId = currentUser.id;
  FirebaseFirestore.instance
    .collection('users')
    .doc(userId)
    .set({'firstName':fName, 'lastName':lName, 'email':email, 'role': role, 'id': userId});
}

