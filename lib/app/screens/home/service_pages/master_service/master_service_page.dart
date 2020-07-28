import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/services/firestore_service.dart';
import 'package:marinez_demo/models/exp_service.dart';
import '../services_list_body.dart';

class MasterServicePage extends StatelessWidget {

  final String title;

  MasterServicePage({this.title});
  
  Widget build(BuildContext context) {

    var serviceType = getServiceTypeIndex(title);

    final firestore = Provider.of<FirestoreService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Servicios Pendientes',
        ),
      ),
      body: StreamProvider(
        create: (_) => firestore.masterServiceListStream(serviceType),
        child: ServicesListBody(),
      ),
    );
  }
}