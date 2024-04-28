import 'package:dio/dio.dart';
import 'package:final_project/config/dio_http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/route_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String? email;
  late String? password;
  late bool _isLoading = false;

  Future<dynamic> _login() async {
    var data = {"email": email, "password": password};
    try {
      // print(data);
      setState(() {
        _isLoading = true;
      });
      var response = await DioHttp.request.post("/api/login", data: data);
      // print(response.data);

      setState(() {
        _isLoading = false;
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user-token', response.data["token"]);
      Get.toNamed(RouteName.bottomNavbar);
    } on DioException catch (dioException) {
      var message = "";
      switch (dioException.response!.statusCode) {
        case 400:
          setState(() {
            _isLoading = false;
          });
          message = dioException.response!.data["message"].toString();
          break;
        case 404:
          setState(() {
            _isLoading = false;
          });
          message = "Server Not Found";
          break;
        default:
          setState(() {
            _isLoading = false;
          });
          message = "Server Error";
      }
      final snackBar = SnackBar(
          content: const Text("invalid Username dan Password"),
          action: SnackBarAction(label: "undo", onPressed: () {}));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 24),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/img/image_1.png",
                        width: 52,
                        height: 57,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      "Selamat Datang \n Kembali",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7D8797)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        validator: (String? emailValue) {
                          if (emailValue!.isEmpty) {
                            return "enter email text";
                          }
                          email = emailValue;
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7D8797)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        validator: (String? passwordValue) {
                          if (passwordValue!.isEmpty) {
                            return "enter password text";
                          }
                          password = passwordValue;
                          return null;
                        },
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Text("Belum Punya akun?"),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(RouteName.registerScreen);
                            },
                            child: const Text(
                              "Daftar",
                              style: TextStyle(color: Color(0xffFF7A3F)),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 142,
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xff1F99CC),
                        borderRadius: BorderRadius.circular(100),
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
                            "Masuk",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      )),
    );
  }
}
