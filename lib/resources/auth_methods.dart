import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:summer_home/models/users.dart' as model;
import 'package:summer_home/resources/storage_methods.dart';
import 'dart:typed_data';

class AuthMethods
{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }


  //signup user
  Future<String> signUpUser(
      {
        required String email,
        required String password,
        required String username,
        required Uint8List file,
      }
      )async{
    String res ='some error occurred';
    try
    {
      if(email.isNotEmpty ||password.isNotEmpty ||username.isNotEmpty || file!=null)
      {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        //print(cred.user!.uid);

        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        //add user to database

        model.User user=model.User(
          uid: cred.user!.uid,
          email: email,
          username: username,
          photoUrl: photoUrl,

        );
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
        //another method if wee don't need uid
        //await _firestore.collection('users').add(
        // {
        // 'username': username,
        //  'uid': cred.user!.uid,
        // 'email': email,
        //'bio': bio,
        //  'followers': [],
        //    'following': [],
        //  }
        //);

        res='success';

      }
      else {
        res = "Please enter all the fields";
      }
    }
    catch(err)
    {
      res=err.toString();
    }
    return res;
  }

//log in user
  Future<String> loginUser(
      {
        required String email,
        required String password,
      }
      )
  async{
    String res ='some error occurred';
    try
    {
      if(email.isNotEmpty ||password.isNotEmpty)
      {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res='success';
      }
      else {
        res = "Please enter all the fields";
      }
    }
    catch(err)
    {
      res=err.toString();
    }
    return res;
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
