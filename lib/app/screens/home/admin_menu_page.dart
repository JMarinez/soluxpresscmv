import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marinez_demo/app/screens/home/profile/profile_page.dart';
import 'package:marinez_demo/components/loading_widget.dart';
import 'package:marinez_demo/components/menu_option.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/menu_provider.dart';
import 'service_pages/master_service/master_service_page.dart';
import 'package:marinez_demo/utils/string_icon_util.dart';

class AdminMenuPage extends StatefulWidget {
  @override
  _AdminMenuPageState createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final firebaseAuth =
        Provider.of<FirebaseAuthService>(context, listen: false);

    return Stack(
      children: <Widget>[
        Scaffold(
          drawer: _buildDrawer(context, firebaseAuth),
          appBar: AppBar(
            title: Text('Servicios Express'),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: menuProvider.getData(),
            initialData: [],
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: LoadingWidget());
              }
              return getMenuGrid(snapshot, context);
            },
          ),
        ),
        _loading ? LoadingWidget() : Container()
      ],
    );
  }

  Drawer _buildDrawer(BuildContext context, FirebaseAuthService firebaseAuth) {
    final user = Provider.of<User>(context, listen: false);

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              child: Icon(
                Icons.person,
                size: 50.0,
                color: Theme.of(context).primaryColor,
              ),
              backgroundColor: Theme.of(context).accentColor,
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage())),
          ),
          Divider(),
          ListTile(
            title: Text('Log Out'),
            onTap: () async => await handleSignOut(firebaseAuth),
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
    );
  }

  Future handleSignOut(FirebaseAuthService firebaseAuth) async {
    setState(() {
      _loading = true;
    });

    await firebaseAuth.signOut();

    setState(() {
      _loading = false;
    });
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

    snapshot.data.forEach(
      (option) {
        var temp = MenuOption(
          title: option['text'],
          iconData: getIcon(option['icon']),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MasterServicePage(title: option['text'])),
            );
          },
        );
        menuList.add(temp);
      },
    );
    return menuList;
  }
}
