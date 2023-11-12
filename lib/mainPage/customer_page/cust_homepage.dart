import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/mainPage/business_owner_page/owner_homepage.dart';
import 'package:flutter_application_1/services/auth/auth_service.dart';
import 'package:flutter_application_1/utilities/dialogs/logout.dart';

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
        child: Container(
          //color: Color.fromARGB(255, 234, 118, 255),
          child: ListView(
            children: [
              Container(
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 227, 73, 254), 
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 46,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.amber
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Welcome", 
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 15, 
                            ),
                            Text("This is customer page"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_outlined,), 
                title:Text('Home', style: TextStyle(color:Colors.black)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => new BusinessOwnerHomePage())
                  );
                }
              ),
              ListTile(
                leading: Icon(Icons.person_outlined,), 
                title:Text('My profile', style: TextStyle(color:Colors.black)),  
                onTap: (){
                  
                }
              ),
              ListTile(
                leading: Icon(Icons.settings_outlined,), 
                title:Text('Setting', style: TextStyle(color:Colors.black)),
                
                onTap: (){}
              ),
              ListTile(
                leading: Icon(Icons.format_quote_outlined,), 
                title:Text('FAQs', style: TextStyle(color:Colors.black)),
                
                onTap: (){}
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined,), 
                title:Text('Logout', style: TextStyle(color:Colors.black)),
                
                onTap: () async{
                  final shouldLogout = await showLogOutDialog(context);
                  //devtools.log(shouldLogout.toString()); //give special output in terminal
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
                }
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,200,0,0),
                child: Container(
                  height: 300,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact Support", 
                        style: TextStyle(
                          color:Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Call us:', 
                            style: TextStyle(
                              color:Colors.black,
                              fontSize: 16,
                              ),
                          ),
                          Text('0123456789', 
                            style: TextStyle(
                              color:Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Mail us:', 
                            style: TextStyle(
                              color:Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text('abc@gmail.com', 
                            style: TextStyle(
                              color:Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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