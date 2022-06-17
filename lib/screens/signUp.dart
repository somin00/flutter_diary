import 'package:flutter/material.dart';
import 'package:myday/screens/MainScreen.dart';
import 'package:myday/screens/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myday/screens/mainPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String userEmail = "";
  String userPwd = "";
  String userName = "";

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text("SignUp", style: TextStyle(fontSize: 20, color: Colors.grey)),
        leading: IconButton(
          color: Colors.grey,
          icon: Icon(Icons.arrow_back_ios_outlined),
          iconSize: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email",
                      style: TextStyle(fontSize: 18, color: Color(0xff8E8E8E))),
                  SizedBox(height: 10),
                  TextFormField(
                    key: ValueKey(1),
                    cursorColor: Color(0xff8E8E8E),
                    style: new TextStyle(color: Color(0xff8E8E8E)),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Color(0xffFFAB91),
                      ),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xffFFAB91))),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:
                            BorderSide(width: 2, color: Color(0xffC9DF9A)),
                      ),
                      filled: true,
                      fillColor: Color(0xffE3F1C7),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffC9DF9A), width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onSaved: (String? value) {
                      userEmail = value!;
                    },
                    onChanged: (value) {
                      userEmail = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text("Password",
                      style: TextStyle(fontSize: 18, color: Color(0xff8E8E8E))),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    key: ValueKey(2),
                    cursorColor: Color(0xff8E8E8E),
                    style: new TextStyle(color: Color(0xff8E8E8E)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffE3F1C7),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      errorStyle: TextStyle(
                        color: Color(0xffFFAB91),
                      ),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xffFFAB91))),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:
                            BorderSide(width: 2, color: Color(0xffC9DF9A)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffC9DF9A), width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onSaved: (String? value) {
                      userPwd = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      userPwd = value;
                    },
                  ),
                  SizedBox(height: 20),
                  Text("Name",
                      style: TextStyle(fontSize: 18, color: Color(0xff8E8E8E))),
                  SizedBox(height: 10),
                  TextFormField(
                    key: ValueKey(3),
                    cursorColor: Color(0xff8E8E8E),
                    style: new TextStyle(color: Color(0xff8E8E8E)),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffE3F1C7),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      errorStyle: TextStyle(
                        color: Color(0xffFFAB91),
                      ),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide:
                              BorderSide(width: 2, color: Color(0xffFFAB91))),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:
                            BorderSide(width: 2, color: Color(0xffC9DF9A)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffC9DF9A), width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onSaved: (String? value) {
                      userName = value!;
                    },
                    onChanged: (value) {
                      userName = value;
                    },
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Already have an account?",
                          style: TextStyle(
                              fontSize: 16, color: Color(0xffc9c9c9))),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Text("SignIn",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff8E8E8E))),
                      )
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final newUser = await _authentication
                                .createUserWithEmailAndPassword(
                                    email: userEmail, password: userPwd);
                            await FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid).set({
                              'userName':userName,
                              'email': userEmail,
                            });
                            if(newUser.user!=null){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return MainScreen();
                              }));
                            }
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "please check your email and password"),
                                backgroundColor: Color(0xffE3F1C7)));
                          }

                          _tryValidation();

                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Color(0xffE3F1C7),
                        ),
                        child: Text("가입하기",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff8E8E8E),
                            ))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
