import 'package:flash_chat/components/input_field.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            InputField(
              hinttextlabel: 'Enter your email',
              onpressed: (value) {},
            ),
            SizedBox(
              height: 8.0,
            ),
            InputField(
              hinttextlabel: 'Enter your password',
              onpressed: (value) {},
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              onPressed: () {
                //Implement login functionality.
              },
              title: 'Login',
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
