import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart'; //For creating the SMTP Server

import 'package:marinez_demo/components/loading_widget.dart';
import 'package:marinez_demo/models/exp_service.dart';
import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/components/submit_button.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firestore_service.dart';

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

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Fomulario de ${widget.title}'),
          ),
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
                      child: _buildSendServiceButton(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _loading ? LoadingWidget() : Container()
      ],
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

  Widget _buildSendServiceButton(BuildContext context) {
    return SubmitButton(
      text: 'Enviar',
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return _showAlertDialog(context);
          },
        );
        Navigator.pop(context);
      },
    );
  }

  Widget _showAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Desea enviar este servicio?'),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar',
                style: TextStyle(color: Theme.of(context).primaryColor))),
        FlatButton(
            onPressed: () async {
              await _sendService(context);
            },
            child: Text('Enviar',
                style: TextStyle(color: Theme.of(context).primaryColor))),
      ],
    );
  }

  Future _sendService(BuildContext context) async {
    final user = Provider.of<FirebaseUser>(context, listen: false);
    final firestore = Provider.of<FirestoreService>(context, listen: false);

    final String hello = user.uid;
    print(hello);

    setState(() {
      _loading = true;
    });

    final snapshot = await firestore.getUserProfile(user);

    final userProfile = ProfileReference.fromMap(snapshot.data);

    final newService = ExpService(
      address: userProfile.address,
      date: DateTime.now(),
      description: _description.text,
      payingMethod: initialValue.index,
      serviceType: getServiceTypeIndex(widget.title),
      status: Status.sent.index,
      userUid: user.uid,
      userEmail: userProfile.email,
      userFullName: userProfile.displayName,
      userPhoneNumber: userProfile.phoneNumber,
    );

    await firestore.setService(user.uid, newService);

  //   String username = "pepsua47@gmail.com";
  //   String password = "modapalafoka3";

  //   final smtpServer = gmail(username, password); 
  //   // Creating the Gmail server

  // // Create our email message.
  //   final message = Message()
  //     ..from = Address(username)
  //     ..recipients.add('dest@example.com') //recipent email
  //     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
  //     ..text = 'This is the plain text.\nThis is line 2 of the text part.' ;//body of the email

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString()); //print if the email is sent
  //   } on MailerException catch (e) {
  //     print('Message not sent. \n'+ e.toString()); //print if the email is not sent
  //     // e.toString() will show why the email is not sending
  //   }

    setState(() {
      _loading = true;
    });

    Navigator.pop(context);
  }
}
