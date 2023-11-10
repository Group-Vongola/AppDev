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
  late final TextEditingController _email;
  late final TextEditingController _password;
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
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            color: Colors.white,
            height: 550,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                          color:Colors.black, 
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                ),
                Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
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
                      ),
                      TextFormField(
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
                      ),
                      TextFormField(
                        controller: _email,
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
                      ),
                      TextFormField(
                        controller: _password,
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
                                }),
                          
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
                      ),
                    ],
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
                          final email = _email.text;
                          final password = _password.text;
                          try{
                            //initial sign up/register
                            setState(() {
                            showProgress = true;
                            });
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
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
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
      )
    );
  }
}