import 'package:flutter/material.dart';

import 'package:marinez_demo/models/exp_service.dart';
import 'package:provider/provider.dart';

import 'service_detail_page.dart';

class ServicesListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ExpService> _serviceList = Provider.of<List<ExpService>>(context);

    if (_serviceList == null) {
      return Center(
        child: Text(
          'No hay servicios en proceso',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    } else if (_serviceList.isEmpty) {
      return Center(
        child: Text(
          'No hay servicios en proceso',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _serviceList?.length ?? 0,
        itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(_serviceList[index].description),
              subtitle: Text(_serviceList[index].userFullName),
              trailing: Icon(Icons.arrow_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ServiceDetailPage(_serviceList[index]);
                  },
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
