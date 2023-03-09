import 'package:cleanning_alert_bussines/authentication/signup_screen.dart';
import 'package:cleanning_alert_bussines/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    'https://assets10.lottiefiles.com/packages/lf20_ZeihcYaIk0.json',
                    height: 300,
                    width: 500),
              ),
              const Text(
                "Cleaning Alert Bussines App",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 130),
                width: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 37, 210, 126),
                  borderRadius: BorderRadius.circular(30),
                  /* infecciosos, escombros, vegetales, industriales, pilas
                  educacion en el bpotado de basura por la humedad que causa y el alto costo para la solucuion,
                  sugerencias para drenar esa basura..... saber tratar la basura gamificacion
                  */
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: const Color.fromARGB(255, 37, 210, 126),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  child: const Text("Ingresar",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MySplashScreen()));
                  },
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Aun no tienes cuenta?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignupScreen()));
                },
                child: const Text(
                  "Registrate",
                  style: TextStyle(
                    color: Color.fromARGB(255, 86, 235, 91),
                    fontSize: 15.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
