import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_flutter_clone_googledoc/models/error_model.dart';
import 'package:project_flutter_clone_googledoc/repository/auth_repository.dart';
import 'package:project_flutter_clone_googledoc/screen/home_screen.dart';
import 'package:project_flutter_clone_googledoc/screen/login_screen.dart';

void main() {
  print("");
  print("Remember to change your IP for authentication to work properly!!");
  print("Remember to change your IP for authentication to work properly!!\n");

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();

    getUserData();
  }

  void getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();

    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
