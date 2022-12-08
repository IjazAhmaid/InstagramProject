import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_app/utlis/colors.dart';
import 'package:instagram_app/utlis/global_variable.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
/*  String username = "";
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  } */
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTaped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ins.svg',
          height: 32,
          color: primaryColor,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            color: _page == 0 ? primaryColor : secondaryColor,
            onPressed: () => navigationTaped(0),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: _page == 1 ? primaryColor : secondaryColor,
            onPressed: () => navigationTaped(1),
          ),
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            color: _page == 2 ? primaryColor : secondaryColor,
            onPressed: () => navigationTaped(2),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color: _page == 3 ? primaryColor : secondaryColor,
            onPressed: () => navigationTaped(3),
          )
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItem,
      ),
    );
  }
}
