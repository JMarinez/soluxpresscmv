import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:marinez_demo/src/widgets/form_input.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // TODO: Logo del app
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Text(
                'Servicios Express',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50.0),
              ),
            ),
            _buildSignupForm(context),
          ],
        ),
      ),
    );
  }

  Container _buildSignupForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                children: <Widget>[
                  _buildNameField(),
                  _buildSurnameField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                children: <Widget>[
                  _buildMobileNumberField(),
                  _buildPhoneNumberField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                children: <Widget>[
                  _buildAddressField(),
                  _buildAddressRefField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                children: <Widget>[
                  _buildEmailField(),
                  _buildPasswordField(),
                  _buildConfirmPasswordField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 36.0),
              child: _buildSignupButton(context),
            ),
          ],
        ),
      ),
    );
  }

  //TODO: Validation, controllers
  Widget _buildNameField() {
    return FormInput(hintText: 'Nombre', prefixIcon: Icon(Icons.person));
  }

  Widget _buildSurnameField() {
    return FormInput(
        hintText: 'Apellido', prefixIcon: Icon(Icons.person_outline));
  }

  Widget _buildMobileNumberField() {
    return FormInput(
        hintText: 'Numero movil', prefixIcon: Icon(Icons.phone_android));
  }

  Widget _buildPhoneNumberField() {
    return FormInput(
        hintText: 'Numero residencial (opcional)',
        prefixIcon: Icon(Icons.phone));
  }

  Widget _buildAddressField() {
    return FormInput(
        hintText: 'Direccion',
        prefixIcon: Icon(Icons.map));
  }

  Widget _buildAddressRefField() {
    return FormInput(
        hintText: 'Referencia (opcional)',
        prefixIcon: Icon(Icons.location_on));
  }

  Widget _buildEmailField() {
    return FormInput(hintText: 'Email', prefixIcon: Icon(Icons.mail_outline));
  }

  Widget _buildPasswordField() {
    return FormInput(hintText: 'Contraseña', prefixIcon: Icon(Icons.lock));
  }

  Widget _buildConfirmPasswordField() {
    return FormInput(
        hintText: 'Confirmar Contraseña', prefixIcon: Icon(Icons.lock_open));
  }

  Widget _buildSignupButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60.0,
        width: double.infinity,
        child: Center(
          child: Text(
            'Registrate',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        color: Theme.of(context).buttonColor,
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
