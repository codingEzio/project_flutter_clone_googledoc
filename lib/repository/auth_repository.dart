import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:project_flutter_clone_googledoc/models/error_model.dart';
import 'package:project_flutter_clone_googledoc/models/user_model.dart';
import 'package:project_flutter_clone_googledoc/constants.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
  })  : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    // Either it succeeds or not, it carries the information for further
    // operation. If it succeeds, we grab the `data` then do something,
    // if it doesn't, we got the `error` and print relevant error message.
    ErrorModel error = ErrorModel(error: 'Unexpected error', data: null);

    try {
      final user = await _googleSignIn.signIn();

      if (user != null) {
        // Since we already en force all the fields here are non-nullable,
        // we could let Dart know that by adding '!' after the variable.
        final userAccount = UserModel(
            email: user.email,
            name: user.displayName!,
            profilePic: user.photoUrl!,
            uid: '',
            token: '');

        // Post authentication user information to our DB backend MongoDB
        var res = await _client.post(Uri.parse('$host/api/signup'),
            body: userAccount.toJson(),
            headers: {'Content-Type': 'application/json; charset=UTF-8'});

        // Do certain things based on the result we got from POSTing data
        switch (res.statusCode) {
          case 200:
            final newUser = userAccount.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
              token: jsonDecode(res.body)['token'],
            );

            error = ErrorModel(error: null, data: newUser);
            break;

          default:
          // pass
        }
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }

    return error;
  }
}
