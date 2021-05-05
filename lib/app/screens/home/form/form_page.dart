import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marinez_demo/services/firebase_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

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
  List<bool> _selections = List.generate(2, (index) => false);
  bool _loading = false;
  PickedFile _image;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildServiceDescriptionField(),
                  Text('Metodo de pago'),
                  _buildPaymentMethodField(),
                  _buildAttachmentsField(),
                  _buildSendServiceButton(context),
                ],
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor describa su situacion';
        }
        return null;
      },
    );
  }

  Widget _buildPaymentMethodField() {
    return Container(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ToggleButtons(
            constraints: BoxConstraints.expand(width: 150),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Tranferencia'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Efectivo'),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < _selections.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    _selections[buttonIndex] = true;
                  } else {
                    _selections[buttonIndex] = false;
                  }
                }
              });
            },
            isSelected: _selections,
          );
        },
      ),
    );
  }

  // Widget _buildPaymentMethodField() {
  //   return Column(
  //     children: <Widget>[
  //       DropdownButton(
  //         value: initialValue,
  //         items: <DropdownMenuItem<Payment>>[
  //           DropdownMenuItem(
  //             child: Text('Efectivo'),
  //             value: Payment.cash,
  //           ),
  //           DropdownMenuItem(
  //             child: Text('Transaccion'),
  //             value: Payment.transaction,
  //           ),
  //         ],
  //         onChanged: (Payment newValue) {
  //           setState(() {
  //             initialValue = newValue;
  //           });
  //         },
  //       ),
  //     ],
  //   );
  // }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();

    var image = await imagePicker.getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() => _image = image);
    }
  }

  //TODO: Usar image picker para insertar una imagen
  // El listado sera un widget ServiceImage, que permitira poder darle tap para poder acercar la imagen
  Widget _buildAttachmentsField() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        width: double.infinity,
        child: _image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo),
                  Text('Seleccione una imagen'),
                ],
              )
            : Image.file(File(_image.path)),
      ),
      onTap: () => getImage(),
    );
  }

  Widget _buildSendServiceButton(BuildContext context) {
    return SubmitButton(
      text: 'Enviar',
      onPressed: () async {
        if (globalKey.currentState.validate()) {
          await showDialog(
            context: context,
            builder: (context) {
              return _showAlertDialog(context);
            },
          );
        }
        Navigator.pop(context);
      },
    );
  }

  Widget _showAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Desea enviar este servicio?'),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar',
                style: TextStyle(color: Theme.of(context).primaryColor))),
        TextButton(
            onPressed: () async {
              await _sendService(context);
            },
            child: Text('Enviar',
                style: TextStyle(color: Theme.of(context).primaryColor))),
      ],
    );
  }

  Future _sendService(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final firestore = Provider.of<FirestoreService>(context, listen: false);
    final storage = Provider.of<FirebaseStorageService>(context, listen: false);

    setState(() {
      _loading = true;
    });

    final snapshot = await firestore.getUserProfile(user);

    final userProfile = ProfileReference.fromMap(snapshot.data());

    final file = File(_image.path);

    final fileName = basename(file.path);

    final storageSnapshot =
        await storage.uploadImage('${user.uid}/serviceImages/$fileName', file);

    final photoUrl = await storageSnapshot.ref.getDownloadURL();

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
        photoUrl: photoUrl);

    await firestore.setService(user.uid, newService);

    setState(() {
      _loading = true;
    });

    Navigator.pop(context);
  }
}
