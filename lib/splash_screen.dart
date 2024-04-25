import 'package:final_project/main.dart';
import 'package:final_project/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    autoLogin();
    super.initState();
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString("user-token");
    if (userToken != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationBarExample()),
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/image_1.png",
              width: 143,
              height: 136,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Flutter Final Project",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
