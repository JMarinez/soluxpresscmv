import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _icons = <String, IconData>{
  'bolt': FontAwesomeIcons.bolt,
  'hardhat': FontAwesomeIcons.hardHat,
  'tools': FontAwesomeIcons.tools,
  'paint': FontAwesomeIcons.paintRoller,
  'faucet': FontAwesomeIcons.faucet,
  'invoice': FontAwesomeIcons.fileInvoiceDollar,
};

IconData getIcon(dynamic iconName) {
  return _icons[iconName];
}
