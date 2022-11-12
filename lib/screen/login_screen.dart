import 'package:flutter/material.dart';
import 'package:project_flutter_clone_googledoc/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          'assets/images/g-logo-2.png',
          height: 25,
        ),
        label: const Text('Sign in with Google'),
        style: ElevatedButton.styleFrom(
          primary: kWhiteColor,
          onPrimary: kBlackColor,
          minimumSize: const Size(150, 50),
        ),
      ),
    ));
  }
}
