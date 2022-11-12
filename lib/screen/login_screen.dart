import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_flutter_clone_googledoc/colors.dart';
import 'package:project_flutter_clone_googledoc/repository/auth_repository.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void signInWithGoogle(WidgetRef ref) {
    ref.read(authRepositoryProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: ElevatedButton.icon(
        onPressed: () => signInWithGoogle(ref),
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
