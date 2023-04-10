import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacebookLoginScreen extends StatefulWidget {
  @override
  _FacebookLoginScreenState createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isSigningIn
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: () async {
            setState(() {
              _isSigningIn = true;
            });

            try {
              final LoginResult result = await _facebookAuth.login();

              if (result.status == LoginStatus.success) {
                final AccessToken accessToken = result.accessToken!;
                final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

                final UserCredential userCredential = await _auth.signInWithCredential(credential);

                final user = userCredential.user;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged in successfully, ${user!.displayName}'),
                  ),
                );
              } else if (result.status == LoginStatus.cancelled) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login cancelled by user'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to sign in with Facebook: ${result.message}'),
                  ),
                );
              }

              setState(() {
                _isSigningIn = false;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to sign in with Facebook: $e'),
                ),
              );

              setState(() {
                _isSigningIn = false;
              });
            }
          },
          child: const Text('Sign in with Facebook'),
        ),
      ),
    );
  }
}
