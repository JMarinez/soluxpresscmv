import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/models/exp_service.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/app/screens/home/service_tab_page/services_list_body.dart';
import 'package:marinez_demo/services/firestore_service.dart';

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
        create: (_) => firestore.serviceListStream(user.uid, Status.sent.index),
        child: ServicesListBody(),
      ),
    );
  }
}
