import 'package:flutter/material.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
              'Home', 
              style: TextStyle(fontSize: 25, color: Colors.black,),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Row(
        children: [
          Container(
            height: 230,
            width: 160,
            decoration: BoxDecoration(
              color:Colors.amber,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Place order'),
                      Text('Here'),
                    ],)
                ),
                
              ],
            ),
          )
        ],
      ),
      
      
    );
  }
  
}