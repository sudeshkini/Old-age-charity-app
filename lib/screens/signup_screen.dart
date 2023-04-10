import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:summer_home/widgets/gradient_button.dart';
import 'package:summer_home/widgets/login_field.dart';
import 'package:summer_home/widgets/social_button.dart';

import '../resources/auth_methods.dart';
import '../resources/facebook_auth.dart';
import '../resources/google_signin.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmpasswordController.dispose();
  }
  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Age Well',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Color.fromRGBO(255, 159, 124, 1),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Sign in.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 50),
               SocialButton(iconPath: 'assets/svgs/g_logo.svg',
                label: 'Continue with Google',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GoogleLoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
               SocialButton(
                iconPath: 'assets/svgs/f_logo.svg',
                label: 'Continue with Facebook',
                horizontalPadding: 90,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FacebookLoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'or',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                    backgroundColor: Colors.red,
                  )
                      : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1543466835-00a7907e9de1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
                    backgroundColor: Colors.red,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),

              const SizedBox(height: 15),
              LoginField(hintText: 'username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(height: 15),
               LoginField(hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(height: 15),
               LoginField(hintText: 'Password',
                 textInputType: TextInputType.text,
                 textEditingController: _passwordController,
                 isPass: true,
               ),
              const SizedBox(height: 20),
               LoginField(hintText: ' Confirm Password',
                textInputType: TextInputType.text,
                textEditingController: _confirmpasswordController,
                isPass: true,),
              const SizedBox(height: 20),
              InkWell(
                child: Container(
                  child: !_isLoading
                      ? const Text(
                    'Sign up',
                  )
                      : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: Color.fromRGBO(255, 159, 124, 1),
                  ),
                ),
                onTap: signUpUser,
              ),
              const SizedBox(
                height: 12,
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Already have an account?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

  




