import 'package:flutter/material.dart';

import 'package:marinez_demo/src/models/exp_service.dart';
import 'package:marinez_demo/src/widgets/form_input.dart';
import 'package:marinez_demo/src/widgets/submit_button.dart';

class FormPage extends StatefulWidget {
  final String title;

  FormPage({this.title});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final globalKey = GlobalKey<FormState>();

  TextEditingController _serviceType = TextEditingController();
  TextEditingController _description = TextEditingController();
  var initialValue = Payment.cash;

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
                  child: _buildSendServiceForm(),
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

  Widget _buildSendServiceForm() {
    return SubmitButton(
      text: 'Enviar',
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
