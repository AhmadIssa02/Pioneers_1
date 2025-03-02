import 'package:flutter/material.dart';

import '../../main_screen.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  String error = "";
  TextEditingController username = TextEditingController(text: "test");
  //TODO: REMOVE THIS
  TextEditingController password = TextEditingController(text: "pass");
  //HI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: username,
              decoration: InputDecoration(
                  hintText: "username",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              obscureText: showPassword ? true : false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                      setState(() {});
                    },
                    icon: Icon(showPassword
                        ? Icons.remove_red_eye_rounded
                        : Icons.remove_red_eye_outlined),
                  ),
                  hintText: "password",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () => {
                      if (username.text == "test" && password.text == "pass")
                        {
                          error = "",
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const MainScreen(),
                            ),
                          ),
                        }
                      else
                        {error = "inavlid credentials", setState(() {})}
                    },
                child: Text("Login")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
