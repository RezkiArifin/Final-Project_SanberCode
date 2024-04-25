import 'package:dio/dio.dart';
import 'package:final_project/config/dio_http.dart';
import 'package:final_project/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String? name;
  late String? username;
  late String? email;
  late String? password;
  late bool _isLoading = false;

  Future<dynamic> _registerSubmit() async {
    var data = {
      "name": name,
      "username": username,
      "email": email,
      "password": password,
    };
    try {
      setState(() {
        _isLoading = true;
      });
      var response = await DioHttp.request.post("/api/register", data: data);

      setState(() {
        _isLoading = false;
      });

      final snackBar = SnackBar(
        content: const Text("Data Berhasil Disimpan"),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {},
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on DioException catch (dioException) {
      var message = "";
      switch (dioException.response!.statusCode) {
        case 422:
          Map<String, dynamic> _errorData =
              dioException.response!.data["errors"];
          var getListMessage = _errorData.values;
          var result = getListMessage.map((item) =>
              item.toString().substring(1, item.toString().length - 2));
          setState(() {
            _isLoading = false;
          });
          message = result.join("\n");
          break;
        case 404:
          setState(() {
            _isLoading = false;
          });
          message = "server not found";
          break;
        default:
          setState(() {
            _isLoading = false;
          });
          message = "Server Error";
      }
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(label: "Undo", onPressed: () {}),
      );
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
                      "Selamat Datang \n Silahkan Mendaftar",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Nama",
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
                        validator: (String? nameValue) {
                          if (nameValue!.isEmpty) {
                            return "enter email text";
                          }
                          name = nameValue;
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
                      "Username",
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
                        validator: (String? usernameValue) {
                          if (usernameValue!.isEmpty) {
                            return "enter email text";
                          }
                          username = usernameValue;
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
                        const Text("Sudah Punya akun?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Color(0xffFF7A3F)),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xff1F99CC),
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        alignment: Alignment.center,
                        child: TextButton(
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _registerSubmit();
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
