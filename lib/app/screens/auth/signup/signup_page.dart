import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marinez_demo/components/loading_widget.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/components/submit_button.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_service.dart';

class SignupPage extends StatefulWidget {
  final Function(int) slideToLoginPage;

  SignupPage(this.slideToLoginPage);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _cnfPass = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _email.dispose();
    _mobileNumber.dispose();
    _pass.dispose();
    _cnfPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => widget.slideToLoginPage(0)),
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
        _loading ? LoadingWidget() : Container(),
      ],
    );
  }

  Container _buildSignupForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
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
      prefixIcon: Icon(Icons.person),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese su nombre';
        }
        return null;
      },
    );
  }

  Widget _buildMobileNumberField() {
    return FormInput(
      controller: _mobileNumber,
      hintText: 'Numero movil',
      prefixIcon: Icon(Icons.phone_android),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese su numero movil';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneNumberField() {
    return FormInput(
      hintText: 'Numero residencial (opcional)',
      prefixIcon: Icon(Icons.phone),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese su numero telefonico';
        }
        return null;
      },
    );
  }

  Widget _buildAddressField() {
    return FormInput(
      controller: _address,
      hintText: 'Direccion',
      prefixIcon: Icon(Icons.map),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese su direccion';
        }
        return null;
      },
    );
  }

  Widget _buildAddressRefField() {
    return FormInput(
      hintText: 'Referencia (opcional)',
      prefixIcon: Icon(Icons.location_on),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese su direccion de referencia';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return FormInput(
      controller: _email,
      hintText: 'Email',
      prefixIcon: Icon(Icons.mail_outline),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese su correo electronico';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return FormInput(
      controller: _pass,
      obscureText: true,
      hintText: 'Contraseña',
      prefixIcon: Icon(Icons.lock),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese su contraseña';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return FormInput(
      controller: _cnfPass,
      obscureText: true,
      hintText: 'Confirmar Contraseña',
      prefixIcon: Icon(Icons.lock_open),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor confirme su contraseña';
        } else if (_pass.text != _cnfPass.text) {
          return 'La contraseña no coincide, intente de nuevo';
        }
        return null;
      },
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return SubmitButton(
      text: 'Registrar',
      onPressed: () async {
        if (formKey.currentState.validate()) {
          await createWithEmailAndPassword(context);
          widget.slideToLoginPage(0);
        }
      },
    );
  }

  Future createWithEmailAndPassword(BuildContext context) async {
    try {
      final firestore = Provider.of<FirestoreService>(context, listen: false);
      final firebaseAuth =
          Provider.of<FirebaseAuthService>(context, listen: false);

      await firebaseAuth
          .createUserWithEmailPassword(
              _email.text.trim(), _pass.text, _name.text.trim())
          .then(
        (user) async {
          await firestore.setUserProfile(
            ProfileReference(
              userUid: user.uid,
              role: 'user',
              email: _email.text.trim(),
              displayName: _name.text.trim(),
              phoneNumber: _mobileNumber.text.trim(),
              address: _address.text,
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
