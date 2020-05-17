import 'package:flutter/material.dart';

import 'package:marinez_demo/models/exp_service.dart';
import 'package:marinez_demo/app/screens/services_tab_pages/finished_services_page.dart';
import 'package:marinez_demo/app/screens/services_tab_pages/progress_services_page.dart';
import 'package:marinez_demo/app/screens/services_tab_pages/queue_services_page.dart';

class PendingServicesPage extends StatelessWidget {
  final List<ExpService> _services = [
    ExpService(
      ServiceType.electricity,
      'Me se daño el transformador. Ayuda!',
      ['assets/electrico.jpg', 'assets/electrico.jpg'],
      'Juan Mariñez',
      'juan.dsmarinez@gmail.com',
      Payment.cash,
      '8097693672',
      Status.in_progress,
    ),
    ExpService(
      ServiceType.paint,
      'Necesito pintar mi casa.',
      ['assets/electrico.jpg', 'assets/electrico.jpg'],
      'Juan Mariñez',
      'juan.dsmarinez@gmail.com',
      Payment.cash,
      '8097693672',
      Status.sent,
    ),
    ExpService(
      ServiceType.paint,
      'Se me picho una goma',
      ['assets/electrico.jpg', 'assets/electrico.jpg'],
      'Juan Mariñez',
      'juan.dsmarinez@gmail.com',
      Payment.cash,
      '8097693672',
      Status.sent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'En espera'),
              Tab(text: 'En proceso'),
              Tab(text: 'Terminado'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            QueueServicesPage(services: _services,),
            ProgressServicesPage(services: _services,),
            FinishedServicesPage(services: _services,),
          ],
        ),
      ),
    );
  }
}
