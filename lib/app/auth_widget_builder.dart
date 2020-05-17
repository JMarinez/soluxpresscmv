import 'package:flutter/material.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  AuthWidgetBuilder({@required this.builder});

  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);

    return StreamBuilder(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<User>.value(
                value: user,
              ),
              Provider<FirestoreService>(
                create: (_) => FirestoreService(),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return Container(
          child: builder(context, snapshot),
        );
      },
    );
  }
}
