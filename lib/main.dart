import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marinez_demo/services/firebase_storage_service.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/app/auth_widget.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';
import 'app/auth_widget_builder.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(),
        ),
      ],
      child: AuthWidgetBuilder(
        builder: (context, userSnapshot) {
          return MaterialApp(
            title: 'Material App',
            debugShowCheckedModeBanner: false,
            home: AuthWidget(userSnapshot: userSnapshot),
            theme: ThemeData(
              primaryColor: Color(0xffffb81e),
              accentColor: Color(0xff55595f),
              buttonColor: Color(0xff55595f),
              cursorColor: Color(0xfffbfef3),
            ),
          );
        },
      ),
    );
  }
}
