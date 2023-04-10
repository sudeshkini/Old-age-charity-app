import 'package:flutter/material.dart';
import 'package:summer_home/utils/pallete.dart';

class GradientButton extends StatefulWidget {
  const GradientButton({Key? key}) : super(key: key);

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isLoading = false;

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // perform the sign up process here

    // set loading to false
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed: signUpUser,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : const Text(
          'Sign in',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
