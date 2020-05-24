import 'package:flutter/material.dart';
import 'package:marinez_demo/models/exp_service.dart';
import 'package:provider/provider.dart';

class QueueServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ExpService> _serviceList = Provider.of<List<ExpService>>(context);
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
          ),
        );
      },
    );
  }
}
