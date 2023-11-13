import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://p5.itc.cn/images01/20230925/e78d0c5543304b0cbd9c3e89ae033c24.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: Colors.blue),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        labelText: 'Full Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Jack Sully',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        labelText: 'Email',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Jacksully@gmail.com',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        labelText: 'Phone Number',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: '012-34567890',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        )
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: (){

                      }, 
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
              
                      }, 
                      child: Text(
                        'Save', 
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
