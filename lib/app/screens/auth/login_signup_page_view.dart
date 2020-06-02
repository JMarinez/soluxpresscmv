import 'package:flutter/material.dart';

import 'package:marinez_demo/app/screens/auth/login/login_page.dart';
import 'package:marinez_demo/app/screens/auth/signup/signup_page.dart';

class LoginSignupPageView extends StatefulWidget {
  @override
  _LoginSignupPageViewState createState() => _LoginSignupPageViewState();
}

class _LoginSignupPageViewState extends State<LoginSignupPageView> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void slideToIndexPage(int index) {
    _controller.animateToPage(index,
        duration: Duration(seconds: 1), curve: Curves.ease);
    _controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        LoginPage(slideToIndexPage),
        SignupPage(slideToIndexPage),
      ],
    );
  }
}
