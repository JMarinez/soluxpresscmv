import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/services/firestore_service.dart';
import 'services_list_body.dart';

class PendingServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirestoreService>(context);
    final user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Servicios Pendientes',
        ),
      ),
      body: StreamProvider(
        create: (_) => firestore.serviceListStream(user.uid),
        child: ServicesListBody(),
      ),
    );
  }
}
