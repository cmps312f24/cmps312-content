import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yalapay/routes/app_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Image.asset('assets/images/YalapayLogo.png',height: 400, width: 400,),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              'Error: 403 Forbidden',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Please ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: "Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        GoRouter.of(context).go(AppRouter.login.path);
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}