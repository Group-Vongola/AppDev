import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                
                child:Image.asset('images/homeImage.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              //color: const Color.fromARGB(255, 33, 243, 72),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Welcome to Sister Fen food delivery",
                        style:TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          color:Colors.blue,
                        ),
                  ),
                  Container(
                    height: 55,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //change the color of button
                        backgroundColor: Colors.purple,
                        minimumSize: Size(188, 36),
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
                      onPressed: () { 
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, 
                          (route) => false,
                        );
                       }, 
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),           
                  ),
                  Container(
                    height: 55,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //change the color of button
                        backgroundColor: Colors.orange,
                        minimumSize: Size(188, 36),
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
                      onPressed: () { 
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute, 
                          (route) => false,
                        );
                       }, 
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),           
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
