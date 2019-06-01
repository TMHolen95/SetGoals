import 'dart:async';

import 'package:augmented_goals/util/authentication.dart';
import 'package:augmented_goals/util/firestore_api.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationCheckBloc{

  AuthenticationCheckBloc();

  FirebaseUser initial(){
    return Auth.firebaseUser;
  }

  Future<bool> signedIn() async {
    await FirestoreAPI.setupFirestore();
    FirebaseUser user = await Auth.getCurrentUser();
    Auth.firebaseUser = user;
    await FirestoreAPI.setExistingAccount();
    return Auth.firebaseUser != null;
  }

}