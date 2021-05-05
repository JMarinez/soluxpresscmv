import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  SubmitButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ElevatedButton(
  //     onPressed: onPressed,
  //     child: Text(text),
  //     style: ElevatedButton.styleFrom(
  //       primary: Theme.of(context).primaryColor,
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     child: Container(
  //       height: 60.0,
  //       width: double.infinity,
  //       child: Center(
  //         child: Text(
  //           text,
  //           style: TextStyle(color: Colors.white, fontSize: 16.0),
  //         ),
  //       ),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(15),
  //         color: Theme.of(context).buttonColor,
  //       ),
  //     ),
  //     onTap: onPressed,
  //   );
  // }
  //

}
