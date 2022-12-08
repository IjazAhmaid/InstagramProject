import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_app/resources/auth_meathod.dart';
import 'package:instagram_app/responsive/mobile_screen_layout.dart';
import 'package:instagram_app/screens/signup.dart';
import 'package:instagram_app/utlis/colors.dart';
import 'package:instagram_app/utlis/global_variable.dart';

import '../responsive/responsive_layout_screens.dart';
import '../responsive/web_screen_layout.dart';
import '../utlis/utlis.dart';
import '../widgets/text_input_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailContrller = TextEditingController();
  final TextEditingController _passwordContrller = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailContrller.dispose();
    _passwordContrller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().loginUser(
        email: _emailContrller.text, password: _passwordContrller.text);
    if (res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobilescreenlayout: MobileScreenLayout(),
                webscreenlayout: WebScreenLayout(),
              )));
    } else {
      showSnackBar(res, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SiginUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webscreensize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3,
              )
            : const EdgeInsets.symmetric(
                horizontal: 32,
              ),
        width: double.infinity,
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            // svg image
            SvgPicture.asset(
              'assets/ins.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            //  input filed for email
            TextInputField(
              hintText: 'Enter Your Email',
              isPass: false,
              textEditingController: _emailContrller,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 25,
            ),
            //  input filed for password
            TextInputField(
              hintText: 'Enter Your Password',
              isPass: true,
              textEditingController: _passwordContrller,
              textInputType: TextInputType.text,
            ),
            // button
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Log in'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            // siging up

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don't have an account?"),
                ),
                GestureDetector(
                  onTap: navigateToSignUp,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Sign up",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
