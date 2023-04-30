import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class User{
  final String email;
  final String uid;
  final String username;
  final String photoUrl;
  final String? idToken;
  //final String token;



  const User({
    required this.username,
    required this.email,
    required this.uid,
    required this.photoUrl,
    this.idToken,
    //required this.token,

  });
  static User fromSnap(DocumentSnapshot? snap, String? idToken) {
    var snapshot = snap?.data() as Map<String, dynamic>?;

    return User(
      uid: snapshot?["uid"] ?? "",
      email: snapshot?["email"] ?? "",
      username: snapshot?["username"] ?? "",
      photoUrl: snapshot?["photoUrl"] ?? "",
      idToken: idToken,
      //token: snapshot?["token"]?? "",


    );
  }

  Map<String ,dynamic> toJson()=>{
    'uid': uid,
    'email': email,
    'username': username,
    'photoUrl': photoUrl,
    //'token': token,
  };
  String? get getIdToken => idToken;
}