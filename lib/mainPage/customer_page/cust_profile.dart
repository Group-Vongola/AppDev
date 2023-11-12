import 'package:flutter/material.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        // New parameter:
        scrolledUnderElevation: 0,
        title: Text(
          'My Profile', 
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), 
          onPressed: () { 
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   welcomeRoute, 
            //   (route) => false,
            // );
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 60,
                color: Colors.amber,
              ),
              Container(
                height: 640,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 236, 236, 236),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          padding: EdgeInsets.only(left:20),

                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mu wan',
                                          style: TextStyle(
                                            fontSize: 24, 
                                            fontWeight: FontWeight.bold, 
                                            color: Colors.black
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text("abc@gmail.com"),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          leading: Icon(Icons.file_copy_outlined),
                          title: Text('Name'),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                        ListTile(
                          leading: Icon(Icons.file_copy_outlined),
                          title: Text('Name'),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:5, left:30),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.amber,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://p5.itc.cn/images01/20230925/e78d0c5543304b0cbd9c3e89ae033c24.png'
                ),
                radius: 55,
                backgroundColor: Colors.white,
              )
            ),
          )
        ],
      ),
    );
  }
}