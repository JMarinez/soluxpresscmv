import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.5,
          child: Container(color: Theme.of(context).accentColor),
        ),
        Card(
          elevation: 0,
          child: Container(
            width: 150.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SpinKitFadingCircle(
                    color: Theme.of(context).accentColor,
                    size: 50.0,
                  ),
                  Text('Cargando', style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
