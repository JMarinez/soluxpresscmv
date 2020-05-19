import 'package:flutter/material.dart';

import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/components/submit_button.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _cnfPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Provider<FirestoreService>(
      create: (_) => FirestoreService(),
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: <Widget>[
                  _buildNameField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: <Widget>[
                  _buildMobileNumberField(),
                  //_buildPhoneNumberField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: <Widget>[
                  _buildAddressField(),
                  //_buildAddressRefField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: <Widget>[
                  _buildEmailField(),
                  _buildPasswordField(),
                  _buildConfirmPasswordField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 36.0),
              child: _buildSignupButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return FormInput(
        controller: _name,
        hintText: 'Nombre completo',
        prefixIcon: Icon(Icons.person));
  }

  Widget _buildMobileNumberField() {
    return FormInput(
        controller: _mobileNumber,
        hintText: 'Numero movil',
        prefixIcon: Icon(Icons.phone_android));
  }

  Widget _buildPhoneNumberField() {
    return FormInput(
        hintText: 'Numero residencial (opcional)',
        prefixIcon: Icon(Icons.phone));
  }

  Widget _buildAddressField() {
    return FormInput(
        controller: _address,
        hintText: 'Direccion',
        prefixIcon: Icon(Icons.map));
  }

  Widget _buildAddressRefField() {
    return FormInput(
        hintText: 'Referencia (opcional)', prefixIcon: Icon(Icons.location_on));
  }

  Widget _buildEmailField() {
    return FormInput(
        controller: _email,
        hintText: 'Email',
        prefixIcon: Icon(Icons.mail_outline));
  }

  Widget _buildPasswordField() {
    return FormInput(
        controller: _pass,
        hintText: 'Contraseña',
        prefixIcon: Icon(Icons.lock));
  }

  Widget _buildConfirmPasswordField() {
    return FormInput(
        controller: _cnfPass,
        hintText: 'Confirmar Contraseña',
        prefixIcon: Icon(Icons.lock_open));
  }

  Widget _buildSignupButton(BuildContext context) {
    return SubmitButton(
        text: 'Registrar',
        onPressed: () async {
          if (_pass.text == _cnfPass.text) {
            await createWithEmailAndPassword(context);
            Navigator.pop(context);
          }
        });
  }

  Future createWithEmailAndPassword(BuildContext context) async {
    try {
      final firebaseAuth =
          Provider.of<FirebaseAuthService>(context, listen: false);
      final user = await firebaseAuth.createUserWithEmailPassword(
          _email.text, _pass.text);
      final firestore = Provider.of<FirestoreService>(context, listen: false);
      await firestore.setUserProfile(
        ProfileReference(
          userUid: user.uid,
          email: _email.text,
          displayName: _name.text,
          phoneNumber: _mobileNumber.text,
          address: _address.text,
        ),
      );
      print(user);
    } catch (e) {
      print(e);
    }
  }
}
