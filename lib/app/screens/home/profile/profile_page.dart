import 'package:flutter/material.dart';
import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context);
    final user = Provider.of<User>(context, listen: false);
    print('User id: ${user.uid}');
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<ProfileReference>(
        stream: firestore.userProfileStream(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final profile = snapshot.data;
            if (profile != null) {
              return Column(
                children: <Widget>[
                  FormInput(initialValue: profile.displayName),
                  FormInput(initialValue: profile.email),
                  FormInput(initialValue: profile.phoneNumber),
                  FormInput(initialValue: profile.address),
                ],
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
