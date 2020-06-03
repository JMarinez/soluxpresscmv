import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/app/auth_widget.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';
import 'app/auth_widget_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
      ],
      child: AuthWidgetBuilder(
        builder: (context, userSnapshot) {
          return MaterialApp(
            title: 'Material App',
            debugShowCheckedModeBanner: false,
            home: AuthWidget(userSnapshot: userSnapshot),
            theme: ThemeData(
              primaryColor: Color(0xff48C3B1),
              accentColor: Color(0xff777779),
              buttonColor: Color(0xff777779),
              cursorColor: Color(0xff48C3B1),
            ),
          );
        },
      ),
    );
  }
}
