import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marinez_demo/components/loading_widget.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/app/screens/home/admin_menu_page.dart';
import 'package:marinez_demo/app/screens/home/menu_page.dart';
import 'package:marinez_demo/app/screens/auth/login_signup_page_view.dart';
import 'package:marinez_demo/services/firestore_service.dart';

class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<FirebaseUser> userSnapshot;

  AuthWidget({@required this.userSnapshot});

  @override
  Widget build(BuildContext context) {
    // if (userSnapshot.connectionState == ConnectionState.active) {
    //   return userSnapshot.hasData ? MenuPage() : LoginSignupPageView();
    // }

    final _firestore = Provider.of<FirestoreService>(context, listen: false);

    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        return FutureBuilder(
          future: _firestore.getUserProfile(userSnapshot.data),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> profileSnapshot) {
            if (profileSnapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(child: LoadingWidget()),
              );
            } else if (profileSnapshot.connectionState ==
                    ConnectionState.done &&
                profileSnapshot.data.data != null) {
              return FutureBuilder(
                future:
                    _firestore.updateDisplayName(context, profileSnapshot.data),
                builder:
                    (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final userProfile =
                        ProfileReference.fromMap(profileSnapshot.data?.data);
                    return userProfile.role == 'admin'
                        ? AdminMenuPage()
                        : MenuPage();
                  }
                  return Scaffold(
                    body: Center(child: LoadingWidget()),
                  );
                },
              );
            }
            return Scaffold(
              body: Center(child: LoadingWidget()),
            );
          },
        );
      } else {
        return LoginSignupPageView();
      }
    }
    return Scaffold(
      body: Center(child: LoadingWidget()),
    );
  }
}
