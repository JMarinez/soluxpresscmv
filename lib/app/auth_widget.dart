import 'package:flutter/material.dart';
import 'package:marinez_demo/app/screens/home/menu_page.dart';
import 'package:marinez_demo/app/screens/login/login_page.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';

class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<User> userSnapshot;

  AuthWidget({@required this.userSnapshot});

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? MenuPage() : LoginPage();
    }
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
