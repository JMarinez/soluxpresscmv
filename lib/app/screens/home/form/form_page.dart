import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:marinez_demo/models/exp_service.dart';
import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/components/submit_button.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  final String title;

  FormPage({this.title});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final globalKey = GlobalKey<FormState>();

  TextEditingController _description = TextEditingController();

  Payment initialValue = Payment.cash;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fomulario de ${widget.title}')),
      body: Container(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildServiceTypeField(),
                _buildServiceDescriptionField(),
                _buildPaymentMethodField(),
                _buildAttachmentsField(),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: _buildSendServiceForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceTypeField() {
    return FormInput(
      initialValue: widget.title,
      readOnly: true,
    );
  }

  Widget _buildServiceDescriptionField() {
    return FormInput(
      controller: _description,
      hintText: 'Descripcion',
    );
  }

  Widget _buildPaymentMethodField() {
    return Column(
      children: <Widget>[
        Text('Metodo de pago'),
        DropdownButton(
          value: initialValue,
          items: <DropdownMenuItem<Payment>>[
            DropdownMenuItem(
              child: Text('Efectivo'),
              value: Payment.cash,
            ),
            DropdownMenuItem(
              child: Text('Transaccion'),
              value: Payment.transaction,
            ),
          ],
          onChanged: (Payment newValue) {
            setState(() {
              initialValue = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAttachmentsField() {
    return Row(
      children: <Widget>[
        Expanded(child: Image.asset('assets/plomero.jpg')),
        Expanded(child: Image.asset('assets/electrico.jpg')),
        Expanded(child: Image.asset('assets/ingeniero.jpg')),
      ],
    );
  }

  Widget _buildSendServiceForm(BuildContext context) {
    return SubmitButton(
      text: 'Enviar',
      onPressed: () async {
        final user = Provider.of<User>(context, listen: false);
        final firestore = Provider.of<FirestoreService>(context, listen: false);
        final snapshot = await firestore.getUserProfile(user.uid);

        final userProfile = ProfileReference.fromMap(snapshot.data);

        final newService = ExpService(
          address: userProfile.address,
          date: DateTime.now(),
          description: _description.text,
          payingMethod: initialValue.index,
          serviceType: getServiceTypeIndex(widget.title),
          status: Status.sent.index,
          userEmail: userProfile.email,
          userFullName: userProfile.displayName,
          userPhoneNumber: userProfile.phoneNumber,
        );

        await firestore.setService(user.uid, newService);
        Navigator.pop(context);
      },
    );
  }
}