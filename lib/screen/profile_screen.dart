import 'package:dio/dio.dart';
import 'package:final_project/config/dio_http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/route_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var temp = "";
  Future<dynamic> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString("user-token");
    setState(() {
      temp == userToken;
    });
    try {
      var response = await DioHttp.request.post("/api/logout",
          options: Options(headers: {"authorization": "Bearer $userToken"}));

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Get.toNamed(RouteName.loginScreen);
    } catch (e) {
      print("Gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 66, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  color: Color(0xff42C6C5)),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffE5E5E5),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundImage: AssetImage('assets/img/passphoto.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rezki Fauzan A.",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        Text(
                          "rezkhyfauzan01@gmail.com",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff42C6C5),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 4)),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _logout();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
