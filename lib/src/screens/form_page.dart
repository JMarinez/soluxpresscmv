import 'package:flutter/material.dart';
import 'package:marinez_demo/src/models/exp_service.dart';
import 'package:marinez_demo/src/widgets/form_input.dart';

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildServiceTypeField(),
                _buildServiceDescriptionField(),
                _buildPaymentMethodField(),
                _buildAttachmentsField(),
                _buildSendServiceForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceTypeField() {
    _serviceType.text = widget.title;
    return FormInput(
      controller: _serviceType,
      enabled: false,
    );
  }

  Widget _buildServiceDescriptionField() {
    return FormInput(
      controller: _description,
      hintText: 'Descripcion',
    );
  }

  Widget _buildPaymentMethodField() {

    return DropdownButton(
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
    return FlatButton(child: Text('Enviar'));
  }
}
