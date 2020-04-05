import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation coloranimation;
  Animation logoanimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      // upperBound: 100,
    );

    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    coloranimation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    logoanimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo);

    controller.forward();

    // controller.reverse(from: 1.0);
    controller.addListener(
      () {
        setState(() {});
        // print(controller.value);
        // print(coloranimation.value);
        // print(logoanimation.value);
      },
    );

    // animation.addStatusListener(
    //   (status) {
    //     if (status == AnimationStatus.completed) {
    //       controller.reverse();
    //     } else if (status == AnimationStatus.dismissed) {
    //       controller.forward();
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(controller.value),

      backgroundColor: coloranimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: logoanimation.value * 100,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  // '${controller.value.toInt()} %',
                  text: ['Flash Chat'], speed: Duration(milliseconds: 300),
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'Login',
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
            ),
            RoundedButton(
              color: Colors.blueAccent,
              title: 'Register',
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
