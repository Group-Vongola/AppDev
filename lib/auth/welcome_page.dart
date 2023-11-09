import 'package:flutter/material.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({super.key});

  @override
  Widget build(BuildContext context) {

    //function for the button
    Widget button({
      required String name,
      required Color color,
      required Color textColor,
    }){
      return Container(
        height: 55,
        width: 200,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            //change the color of button
            backgroundColor: color,
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
          onPressed: () {  }, 
          child: Text(
            name,
            style: TextStyle(color: textColor, fontSize: 25),
          ),
        ),           
      );
    }
    
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
                  button(name: 'Login', color: Colors.purple, textColor: Colors.white),
                  button(name: 'Register', color: Colors.orange, textColor: Colors.black),

                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
