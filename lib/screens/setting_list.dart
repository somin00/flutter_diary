import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myday/screens/MainScreen.dart';
import 'package:myday/screens/startPage.dart';

class SettingList extends StatefulWidget {
  const SettingList({Key? key}) : super(key: key);

  @override
  State<SettingList> createState() => _SettingListState();
}

class _SettingListState extends State<SettingList> {
  bool isOn = false;
  final _authentication=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Setting", style: TextStyle(fontSize: 20, color: Colors.grey)),
        // leading: IconButton(onPressed: (){
        //   Navigator.pop(context);
        // }, icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.grey[500])),
        leading: Container(),
      ),
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Notice",
                            style: TextStyle(fontSize: 18, color: Color(0xffC9C9C9))),
                        SizedBox(height: 10),
                        Container(
                          // margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              // border: Border.all(color: Colors.black38),
                              color: Colors.lightGreen[200]),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ON/OFF",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  IconButton(
                                      splashColor: Colors.transparent,
                                      padding: EdgeInsets.only(bottom: 30),
                                      constraints: BoxConstraints(maxHeight: 30),
                                      onPressed: () {
                                        setState(() {
                                          this.isOn? isOn=false: isOn=true;
                                        });
                                      },
                                      icon: Icon(
                                        isOn? Icons.toggle_on: Icons.toggle_off,
                                        size: 30,
                                        color: Colors.white,
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("INFO",
                            style: TextStyle(fontSize: 18, color: Color(0xffC9C9C9))),
                        SizedBox(height: 10),
                        Container(
                            width: 400,
                            // margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                // border: Border.all(color: Colors.black38),
                                color: Colors.lightGreen[200]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {
                                        // _authentication.signOut();
                                        // print(_authentication.currentUser);
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StartPage()));
                                      },
                                      child: const Text("Logout",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.white)),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home, color: Colors.white),
          backgroundColor: Colors.lightGreen[200],
          elevation: 0,
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
