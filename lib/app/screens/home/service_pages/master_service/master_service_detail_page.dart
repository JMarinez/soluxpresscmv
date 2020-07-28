import 'package:flutter/material.dart';
import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/constants/constants.dart';
import 'package:marinez_demo/models/exp_service.dart';

class MasterServiceDetailPage extends StatefulWidget {
  final ExpService service;

  MasterServiceDetailPage(this.service);

  @override
  _MasterServiceDetailPageState createState() => _MasterServiceDetailPageState();
}

class _MasterServiceDetailPageState extends State<MasterServiceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
            initialValue: widget.service.getServiceTypeDescription(widget.service.serviceType),
            readOnly: true,
          ),
          Text('Status', style: kForumInputHeaderSize),
          FormInput(
            initialValue: widget.service.getStatusDescription(widget.service.status),
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
        ],
      ),
    );
  }
}
