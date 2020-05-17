import 'dart:convert';

import 'package:flutter/services.dart';

class _MenuProvider {

  Future<List<dynamic>> getData() async{

    var response = await rootBundle.loadString('data/menu_opts.json');

    var decode = json.decode(response);
    var dataMap = decode['routes'];
    
    return dataMap;
  }
}

var menuProvider = _MenuProvider();
