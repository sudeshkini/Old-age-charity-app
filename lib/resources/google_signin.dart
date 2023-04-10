import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginScreen extends StatefulWidget {
  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isSigningIn = false;

  Future<void> _handleSignIn() async {
    setState(() {
      _isSigningIn = true;
    });

    try {
      final GoogleSignInAccount? googleUser =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

      final AuthCredential credential =
      GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged in successfully, ${user!.displayName}'),
        ),
      );

      setState(() {
        _isSigningIn = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google: $e'),
        ),
      );

      setState(() {
        _isSigningIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isSigningIn
            ? const CircularProgressIndicator()
            : GestureDetector(
          onTap: _handleSignIn,
          child: ElevatedButton(
            onPressed: null,
            child: const Text('Sign in with Google'),
          ),
        ),
      ),
    );
  }
}
