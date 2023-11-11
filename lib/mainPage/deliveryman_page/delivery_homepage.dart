import 'package:flutter/material.dart';

class DeliverymanHomePage extends StatefulWidget {
  const DeliverymanHomePage({super.key});

  @override
  State<DeliverymanHomePage> createState() => _DeliverymanHomePageState();
}

class _DeliverymanHomePageState extends State<DeliverymanHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: Text(
          'Delivery Man', 
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
  
}