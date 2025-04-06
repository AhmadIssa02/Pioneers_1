import 'package:chat_app/screens/login/widgets/custom_Icon_btn.dart';
import 'package:chat_app/screens/login/widgets/custom_textfield.dart';
import 'package:chat_app/screens/mainScreen/main_screen.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: "Enter user name to use the app",
            ),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextfield(controller: controller),
                  ),
                  CustomIconBtn(onTap: () {
                    {
                      if (controller.text.isEmpty) {
                        _showToastMessages(context);
                        return;
                      }

                      _navigateToMainScreen(context, controller.text);
                    }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showToastMessages(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("nickname can't be empty"),
    ));
  }

  _navigateToMainScreen(BuildContext context, String username) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (ctx) {
        return MainScreen(nickname: int.tryParse(username) ?? 0);
      },
    ), (Route<dynamic> route) => false);
  }
}
