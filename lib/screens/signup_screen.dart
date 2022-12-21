import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mint/screens/mintPage.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _sexController.dispose();
    _ageController.dispose();
    _regionController.dispose();
  }

  // void selectImage() async {
  //   Uint8List im = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = im;
  //   });
  // }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      sex: _sexController.text,
      age: int.parse(_ageController.text),
      region: _regionController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MintPage()),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            // 이미지
            // Container(
            //   padding: EdgeInsets.only(top: 20),
            //   child: Image.asset(
            //     'mint_logo.png',
            //     width: 350,
            //   ),
            // ),
            Text(
              " 민초 vs 반민초",
              style: TextStyle(
                  color: mintColor, fontSize: 50, fontFamily: 'Human'),
            ),
            SizedBox(
              height: 64,
            ),
            // 유저네임
            // 이메일
            TextFieldInput(
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            SizedBox(
              height: 24,
            ),
            // 패스워드
            TextFieldInput(
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Enter your username',
              textInputType: TextInputType.text,
              textEditingController: _usernameController,
            ),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Enter your region',
              textInputType: TextInputType.text,
              textEditingController: _regionController,
            ),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Enter your sex',
              textInputType: TextInputType.text,
              textEditingController: _sexController,
            ),
            SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Enter your age',
              textInputType: TextInputType.number,
              textEditingController: _ageController,
            ),
            SizedBox(
              height: 24,
            ),

            // 로그인
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign up'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Do you have an account? "),
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    child: Text(
                      "Log in.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                )
              ],
            )
            // 회원가입
          ]),
        ),
      ),
    );
  }
}
