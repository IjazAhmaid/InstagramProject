import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/resources/auth_meathod.dart';
import 'package:instagram_app/screens/login_screens.dart';
import 'package:instagram_app/utlis/colors.dart';
import 'package:instagram_app/utlis/utlis.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screens.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/text_input_filed.dart';

class SiginUpScreen extends StatefulWidget {
  const SiginUpScreen({super.key});

  @override
  State<SiginUpScreen> createState() => _SiginUpScreenState();
}

class _SiginUpScreenState extends State<SiginUpScreen> {
  final TextEditingController _emailContrller = TextEditingController();
  final TextEditingController _passwordContrller = TextEditingController();
  final TextEditingController _bioContrller = TextEditingController();
  final TextEditingController _usernameContrller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailContrller.dispose();
    _passwordContrller.dispose();
    _bioContrller.dispose();
    _usernameContrller.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void siginupuser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
        email: _emailContrller.text,
        password: _passwordContrller.text,
        username: _usernameContrller.text,
        bio: _bioContrller.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });
    if (res != 'sucess') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobilescreenlayout: MobileScreenLayout(),
                webscreenlayout: WebScreenLayout(),
              )));
    }
  }

  void navigateToLoginScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(
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
              height: 60,
            ),
            const SizedBox(
              height: 12,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://www.pngitem.com/pimgs/m/22-223968_default-profile-picture-circle-hd-png-download.png')),
                Positioned(
                    bottom: -10,
                    left: 90,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            //  input filed for username
            TextInputField(
              hintText: 'Enter Your UserName',
              isPass: false,
              textEditingController: _usernameContrller,
              textInputType: TextInputType.text,
            ),

            const SizedBox(
              height: 12,
            ),
            //  input filed for email
            TextInputField(
              hintText: 'Enter Your Email',
              isPass: false,
              textEditingController: _emailContrller,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 12,
            ),
            //  input filed for password
            TextInputField(
              hintText: 'Enter Your Password',
              isPass: true,
              textEditingController: _passwordContrller,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 12,
            ),
            //  input filed for bio
            TextInputField(
              hintText: 'Enter Your Bio',
              isPass: false,
              textEditingController: _bioContrller,
              textInputType: TextInputType.text,
            ),

            const SizedBox(
              height: 12,
            ), // button
            InkWell(
              onTap: siginupuser,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ))
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          color: blueColor),
                      child: const Text('Sign Up'),
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 0,
              child: Container(),
            ),
            // siging up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("All Ready have an account?"),
                ),
                GestureDetector(
                  onTap: navigateToLoginScreen,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Login",
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
