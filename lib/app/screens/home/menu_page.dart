import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marinez_demo/app/screens/home/form/form_page.dart';
import 'package:marinez_demo/app/screens/home/service_tab_page/pending_services_page.dart';
import 'package:marinez_demo/app/screens/home/profile/profile_page.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/menu_provider.dart';
import 'package:marinez_demo/components/menu_option.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseAuth =
        Provider.of<FirebaseAuthService>(context, listen: false);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                      size: 40.0,
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 40.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Juan Jose Mariñez Fernandez'),
                ],
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage())),
            ),
            Divider(),
            ListTile(
              title: Text('Log Out'),
              onTap: () async => await firebaseAuth.signOut(),
            ),
            Divider(),
            ListTile(
              title: Text('Acerca del app'),
              onTap: () => showAboutDialog(
                context: context,
                applicationVersion: '0.1',
                applicationName: 'Servicios Express',
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Servicios Express'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.inbox,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PendingServicesPage(),
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: menuProvider.getData(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return getMenuGrid(snapshot, context);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: Container(
        child: Center(
            child: FaIcon(
          FontAwesomeIcons.ambulance,
          color: Theme.of(context).primaryColor,
        )),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(100.0)),
        height: 75.0,
        width: 75.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  GridView getMenuGrid(
      AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
      ),
      padding: EdgeInsets.all(25),
      children: getMenuOptions(snapshot, context),
    );
  }

  List<Widget> getMenuOptions(
      AsyncSnapshot<List<dynamic>> snapshot, BuildContext context) {
    List<MenuOption> menuList = [];

    snapshot.data.forEach((option) {
      var temp = MenuOption(
        title: option['text'],
        imageData: option['image'],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPage(
                title: option['text'],
              ),
            ),
          );
        },
      );
      menuList.add(temp);
    });

    return menuList;
  }
}
