import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
      body: Container(
        //create the margin in left and right
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: 
        Padding(
          padding: const EdgeInsets.only(top:100),
          child: Container(
            color: Colors.white,
            height: 500,
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
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: 'Enter your email here',
                      ),
                    ),
                    
                    //to adjust space between two text field
                    const SizedBox(height: 20,),

                    TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                         prefixIcon: Icon(Icons.lock_outline),
                        hintText: 'Enter your password here',
                      ),
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
                    onPressed: () {  }, 
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),           
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  TextButton(
                    onPressed: (){
                      //on pressed, will lead to register page
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //   registerRoute, 
                      //   (route) => false,
                      // );
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
                    child: const Text('Not registered yet? Register here!'),
                  )
                ],),
              ],
            ),
          ),
        ),
      )
    );
  }
}