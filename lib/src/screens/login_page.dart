import 'package:flutter/material.dart';

import 'package:marinez_demo/src/widgets/form_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _focusEmailNode = FocusNode();
  final FocusNode _focusPasswordNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildLoginForm(context),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: _buildSignupPagePush(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLoginForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
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

  GestureDetector _buildLoginButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60.0,
        width: double.infinity,
        child: Center(
          child: Text(
            'Log in',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        color: Theme.of(context).buttonColor,
      ),
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        Navigator.pushNamed(context, 'menu');
      },
    );
  }

  Widget _buildEmailField() {
    return FormInput(
      focusNode: _focusEmailNode,
      controller: _email,
      hintText: 'Email',
      prefixIcon: Icon(Icons.mail_outline),
    );
  }

  Widget _buildPasswordField() {
    return FormInput(
      focusNode: _focusPasswordNode,
      controller: _password,
      hintText: 'Contraseña',
      prefixIcon: Icon(Icons.lock),
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
          Navigator.pushNamed(context, 'signup');
        });
  }
}
