import 'package:flutter/material.dart';
import 'package:marinez_demo/src/screens/form_page.dart';
import 'package:marinez_demo/src/screens/login_page.dart';
import 'package:marinez_demo/src/screens/menu_page.dart';
import 'package:marinez_demo/src/screens/pending_services_page.dart';
import 'package:marinez_demo/src/screens/signup_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        'menu': (context) => MenuPage(),
        'form': (context) => FormPage(),
        'signup': (context) => SignupPage(),
        'pending': (context) => PendingServicesPage(),
      },
      theme: ThemeData(
        primaryColor: Color(0xff48C3B1),
        accentColor: Color(0xff777779),
        buttonColor: Color(0xff777779),
        cursorColor: Color(0xff48C3B1),
      ),
    );
  }
}
