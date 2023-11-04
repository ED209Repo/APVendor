import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/HomeScreen.dart';
import 'onBoardingScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    );

    _animationController.forward().then((value) async {
      final preferences = await SharedPreferences.getInstance();
      final String? phoneNumber = preferences.getString('phoneNumber');

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        // User's phone number exists in stored data, navigate to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // User's phone number doesn't exist in stored data, navigate to onboarding
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset("images/mainlogo.png")),
              Lottie.asset(
                "images/splash2.json", // Replace this with the correct path to your Lottie animation file.
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController
                    ..duration = composition.duration
                    ..forward().then((value) async {
                      final preferences = await SharedPreferences.getInstance();
                      final String? phoneNumber = preferences.getString('phoneNumber');

                      if (phoneNumber != null && phoneNumber.isNotEmpty) {
                        // User's phone number exists in stored data, navigate to the home screen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } else {
                        // User's phone number doesn't exist in stored data, navigate to onboarding
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const OnboardScreen()),
                        );
                      }
                    });
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
