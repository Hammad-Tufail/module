import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/OvalButton.dart';
import 'package:chat_app/loginscreen.dart';
import 'package:chat_app/registrationscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'Welcomescreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation colorAnim;
  Animation curveAnim;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    curveAnim = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    colorAnim = ColorTween(begin: Colors.grey[700], end: Colors.white)
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnim.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'pic',
                  child: Container(
                    child: Image.asset('images/pic.png'),
                    height: curveAnim.value * 50,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Human Organ'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  isRepeatingAnimation: false,
                  speed: Duration(milliseconds: 300),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            OvalButton(
              color: Colors.lightBlue,
              text: 'Login',
              onpress: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            OvalButton(
              color: Colors.blueAccent,
              onpress: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Registration',
            ),
          ],
        ),
      ),
    );
  }
}
