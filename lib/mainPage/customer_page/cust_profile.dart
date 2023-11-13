import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  var size, heightMax, widthMax;
  final currentUser = AuthService.firebase().currentUser;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    heightMax = size.height;
    widthMax = size.width;
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
        body: Container(
          child: StreamBuilder<DocumentSnapshot>(
              stream: userCollection.doc(currentUser?.id).snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 60,
                          color: Colors.amber,
                        ),
                        Expanded(
                          child: Container(
                            height: heightMax,
                            width: widthMax,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
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
                                  children: [
                                    Container(
                                      width: 250,
                                      height: 90,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Divider(
                                      height: 56,
                                      color: Colors.black,
                                    ),
                                    ListTile(
                                      leading: Icon(
                                          Icons.account_circle_outlined,
                                          size: 40),
                                      // title: Text(
                                      //   streamSnapshot.data?['name'],
                                      // ),
                                      //title: Text('Name'),
                                      //trailing: Icon(Icons.arrow_forward_ios_outlined),
                                    ),
                                    ListTile(
                                      leading:
                                          Icon(Icons.email_outlined, size: 40),
                                      //title: Text(
                                      //streamSnapshot.data['email'],
                                      //),
                                      //title: Text('Email'),
                                      //trailing: Icon(Icons.arrow_forward_ios_outlined),
                                    ),
                                    ListTile(
                                      leading:
                                          Icon(Icons.phone_outlined, size: 40),
                                      //title: Text('Phone Number'),
                                      //trailing: Icon(Icons.arrow_forward_ios_outlined),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        width: 180,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            //change the color of button
                                            backgroundColor: Colors.amber,
                                            minimumSize: Size(188, 36),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            //change the border to rounded side
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                              side: BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                            ),
                                            //construct shadow color
                                            elevation: 10,
                                            shadowColor: const Color.fromARGB(
                                                255, 92, 90, 85),
                                          ).copyWith(
                                            //change color onpressed
                                            overlayColor: MaterialStateProperty
                                                .resolveWith<Color?>(
                                                    (Set<MaterialState>
                                                        states) {
                                              if (states.contains(
                                                  MaterialState.pressed))
                                                return Colors.blue;
                                              return null; // Defer to the widget's default.
                                            }),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: AlignmentDirectional.topCenter,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.amber,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://p5.itc.cn/images01/20230925/e78d0c5543304b0cbd9c3e89ae033c24.png'),
                          radius: 75,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }
}
