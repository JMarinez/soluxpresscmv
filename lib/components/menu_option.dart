import 'package:flutter/material.dart';
import 'package:marinez_demo/app/screens/form_page.dart';
import 'package:marinez_demo/components/option_clip.dart';

class MenuOption extends StatelessWidget {
  final String title;
  final String imageData;

  MenuOption({this.title, this.imageData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ClipOval(
                child: Image.asset(imageData),
                clipper: OptionClip(),
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              title,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormPage(
              title: title,
            ),
          ),
        );
      },
    );
  }
}
