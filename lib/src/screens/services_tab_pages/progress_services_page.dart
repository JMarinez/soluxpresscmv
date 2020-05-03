import 'package:flutter/material.dart';
import 'package:marinez_demo/src/models/exp_service.dart';

class ProgressServicesPage extends StatelessWidget {
  final bool isEmpty;
  final Status status;
  final List<ExpService> services;

  ProgressServicesPage(
      {this.isEmpty = true, this.status = Status.in_progress, this.services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createServicesList(context)
    );
  }

  Widget _createServicesList(BuildContext context) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        if (services[index].serviceStatus == Status.in_progress) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(services[index].serviceDescription),
              subtitle: Text(services[index].userFullName),
              trailing: Icon(Icons.arrow_right),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
