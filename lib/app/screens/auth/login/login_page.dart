import 'package:flutter/material.dart';
import 'package:marinez_demo/components/loading_widget.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _focusEmailNode = FocusNode();
  final FocusNode _focusPasswordNode = FocusNode();
  bool _loading = false;

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
                  _buildLoginForm(context),
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: _buildSignupPagePush(context),
                  ),
                ],
              ),
            ),
          ),
        ),
        _loading ? LoadingWidget() : Container()
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
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

  Widget _buildLoginButton(BuildContext context) {
    return SubmitButton(
      text: 'Log in',
      onPressed: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

        final firebaseAuth =
            Provider.of<FirebaseAuthService>(context, listen: false);

        setState(() {
          _loading = true;
        });

        await firebaseAuth.signInWithEmailAndPassword(
            _email.text, _password.text);

        setState(() {
          _loading = false;
        });
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
      obscureText: true,
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
          widget.slideToSignupPage(1);
        });
  }
}
