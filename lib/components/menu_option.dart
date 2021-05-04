import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function onPressed;

  MenuOption({this.title, this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: FaIcon(
                    iconData,
                    size: 60,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
