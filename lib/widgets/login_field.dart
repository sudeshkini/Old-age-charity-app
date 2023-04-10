import 'package:flutter/material.dart';
import 'package:summer_home/utils/pallete.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isPass;
  final TextInputType textInputType;
  const LoginField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.isPass = false,
    required this.textInputType,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.gradient2,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
        ),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }
}
