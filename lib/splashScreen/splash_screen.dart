import 'dart:async';
import 'package:cleanning_alert_bussines/mainScreens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cleanning_alert_bussines/authentication/login_screen.dart';
import 'package:cleanning_alert_bussines/global/global.dart';
import 'package:cleanning_alert_bussines/mainScreens/main_screens.dart';
import 'package:lottie/lottie.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 5, 125, 113),
              Color.fromARGB(255, 5, 125, 113),
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Lottie.network(
                    'https://assets8.lottiefiles.com/packages/lf20_jjoydpqg.json'),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Espere por favor....',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
