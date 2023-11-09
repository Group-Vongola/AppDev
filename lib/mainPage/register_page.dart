
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  Widget button({
    required String buttonName,
    required Color color,
  }){
    return Container(
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          //change the color of button
          backgroundColor: color,
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
        onPressed: () {  }, 
        child: Text(
          buttonName,
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
    );        
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 219, 255),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), 
          onPressed: () { 

          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            color: Colors.white,
            height: 400,
            margin: EdgeInsets.symmetric(horizontal: 50),
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
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: 'Enter your email here',
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: 'Enter your password',
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: 'Confirm password',
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: button(
                          buttonName: 'Cancel',
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: button(
                          buttonName: 'Register',
                          color: Colors.amber,
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}