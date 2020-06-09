import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/constants/constants.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context);
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Perfil'),
      ),
      body: StreamBuilder<ProfileReference>(
        stream: firestore.userProfileStream(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final profile = snapshot.data;
            if (profile != null) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text('Nombre', style: kForumInputHeaderSize),
                    FormInput(
                      initialValue: profile.displayName,
                      readOnly: true,
                    ),
                    Text('Email', style: kForumInputHeaderSize),
                    FormInput(
                      initialValue: profile.email,
                      readOnly: true,
                    ),
                    Text('Numero telefonico', style: kForumInputHeaderSize),
                    FormInput(
                      initialValue: profile.phoneNumber,
                      readOnly: true,
                    ),
                    Text('Direccion', style: kForumInputHeaderSize),
                    FormInput(
                      initialValue: profile.address,
                      readOnly: true,
                    ),
                  ],
                ),
              );
            }
          }
          return Center(
            child: SpinKitFadingCircle(
              size: 50.0,
              color: Theme.of(context).accentColor,
            ),
          );
        },
      ),
    );
  }
}
