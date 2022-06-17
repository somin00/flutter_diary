import 'package:flutter/material.dart';
import 'package:myday/screens/signIn.dart';
import 'package:myday/screens/signUp.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.0,
            ),
            Center(child: Text("MYDAY", style: TextStyle(
              fontSize: 30.0,
              color:  Colors.lightGreen[300],
            ))),
            SizedBox(height: 70.0),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Color(0xffE3F1C7),

                      ),
                      child: Text("회원가입",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff8E8E8E),
                          ))),
                  SizedBox(
                    height: 5.0
                  ),
                  ElevatedButton(
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Color(0xffE3F1C7),

                      ),
                      child: Text("로그인",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff8E8E8E),
                          ))),
                ],
              ),
            )
          ],
        )

      ),
    );
  }
}
