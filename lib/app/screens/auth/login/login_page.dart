import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:marinez_demo/components/loading_widget.dart';
import 'package:marinez_demo/components/form_input.dart';
import 'package:marinez_demo/components/submit_button.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function(int) slideToSignupPage;

  LoginPage(this.slideToSignupPage);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _focusEmailNode = FocusNode();
  final FocusNode _focusPasswordNode = FocusNode();
  bool _loading = false;
  String _errorMessage;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _focusEmailNode.dispose();
    _focusPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Text(
                      'Servicios Express',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 50.0),
                    ),
                  ),
                  _buildLoginForm(context, formKey),
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: _buildSignupPagePush(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        _loading
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
              )
            : Container()
      ],
    );
  }

  _showAlert() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "ERROR",
      desc: _errorMessage,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  Widget _buildLoginForm(BuildContext context, GlobalKey key) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: key,
        child: Column(
          children: <Widget>[
            _buildEmailField(),
            _buildPasswordField(),
            _buildLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SubmitButton(
      text: 'Log in',
      onPressed: () async {
        try {
          if (formKey.currentState.validate()) {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            final firebaseAuth =
                Provider.of<FirebaseAuthService>(context, listen: false);

            await firebaseAuth.signInWithEmailAndPassword(
                _email.text.trim(), _password.text);
          }
        } catch (e) {
          setState(() {
            _errorMessage = e.message;
          });
          _showAlert();
        }
      },
    );
  }

  Widget _buildEmailField() {
    return FormInput(
      focusNode: _focusEmailNode,
      controller: _email,
      hintText: 'Email',
      prefixIcon: Icon(Icons.mail_outline),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese su correo';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return FormInput(
      focusNode: _focusPasswordNode,
      controller: _password,
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

  Widget _buildSignupPagePush(BuildContext context) {
    return GestureDetector(
        child: Text(
          'No tienes una cuenta? Registrate.',
          style:
              TextStyle(fontSize: 16.0, decoration: TextDecoration.underline),
        ),
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          widget.slideToSignupPage(1);
        });
  }
}
