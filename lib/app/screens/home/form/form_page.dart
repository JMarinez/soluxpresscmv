import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    Column(
                      children: [
                        _buildServiceTypeField(),
                        _buildServiceDescriptionField(),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('Metodo de pago'),
                          _buildPaymentMethodField()
                        ],
                      ),
                    ),
                    Expanded(flex: 4, child: _buildAttachmentsField()),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: _buildSendServiceButton(context),
                      ),
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

  //TODO: Usar multi image picker para insertar imagenes (al menos 3)
  // Crear una lista donde se almacenaran las imagenes
  // El listado sera un widget ServiceImage, que permitira poder darle tap para poder acercar la imagen
  Widget _buildAttachmentsField() {
    return Container(
      child: ListView(
        children: <Widget>[
          Image.asset('assets/plomero.jpg'),
          Image.asset('assets/electrico.jpg'),
          Image.asset('assets/ingeniero.jpg'),
        ],
      ),
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

    setState(() {
      _loading = true;
    });

    Navigator.pop(context);
  }
}
