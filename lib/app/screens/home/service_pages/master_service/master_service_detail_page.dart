import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/constants/constants.dart';
import 'package:marinez_demo/models/exp_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';

class MasterServiceDetailPage extends StatefulWidget {
  final ExpService service;

  MasterServiceDetailPage(this.service);

  @override
  _MasterServiceDetailPageState createState() =>
      _MasterServiceDetailPageState();
}

class _MasterServiceDetailPageState extends State<MasterServiceDetailPage> {
  @override
  Widget build(BuildContext context) {

    final firestore = Provider.of<FirestoreService>(context);
    double value = widget.service.status.toDouble();
    String statusDesc = widget.service.getStatusDescription(widget.service.status);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text('Descripcion', style: kForumInputHeaderSize),
            FormInput(
              initialValue: widget.service.description,
              readOnly: true,
            ),
            Text('Servicio', style: kForumInputHeaderSize),
            FormInput(
              initialValue: widget.service
                  .getServiceTypeDescription(widget.service.serviceType),
              readOnly: true,
            ),
            Text('Status', style: kForumInputHeaderSize),
            FormInput(
              initialValue:
                 statusDesc,
              readOnly: true,
            ),
            Text('Nombre', style: kForumInputHeaderSize),
            FormInput(
              initialValue: widget.service.userFullName,
              readOnly: true,
            ),
            Text('Email', style: kForumInputHeaderSize),
            FormInput(
              initialValue: widget.service.userEmail,
              readOnly: true,
            ),
            Text('Numero telefonico', style: kForumInputHeaderSize),
            FormInput(
              initialValue: widget.service.userPhoneNumber,
              readOnly: true,
            ),
            Text('Direccion', style: kForumInputHeaderSize),
            FormInput(
              initialValue: widget.service.address,
              readOnly: true,
            ),
            Slider(
              value: value,
              min: 1,
              max: 3,
              divisions: 2,
              label: widget.service.getStatusDescription(widget.service.status),
              onChanged: (newValue) async {
                setState(() {
                  value = newValue;
                  statusDesc = widget.service.getStatusDescription(newValue.toInt());
                });
                await firestore.updateServiceStatus(widget.service, newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
