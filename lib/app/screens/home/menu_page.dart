import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marinez_demo/app/screens/home/form/form_page.dart';
import 'package:marinez_demo/app/screens/home/service_tab_page/pending_services_page.dart';
import 'package:marinez_demo/app/screens/home/profile/profile_page.dart';
import 'package:marinez_demo/components/loading_widget.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/menu_provider.dart';
import 'package:marinez_demo/components/menu_option.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      SpinKitFadingCircle(
                        color: Theme.of(context).accentColor,
                        size: 50.0,
                      ),
                      Text('Cargando')
                    ],
                  ),
                );
              }
              return getMenuGrid(snapshot, context);
            },
          ),
          // bottomNavigationBar: BottomAppBar(
          //   child: Container(
          //     height: 50.0,
          //   ),
          // ),
          // floatingActionButton: Container(
          //   child: Center(
          //       child: FaIcon(
          //     FontAwesomeIcons.ambulance,
          //     color: Theme.of(context).primaryColor,
          //   )),
          //   decoration: BoxDecoration(
          //       color: Theme.of(context).accentColor,
          //       borderRadius: BorderRadius.circular(100.0)),
          //   height: 75.0,
          //   width: 75.0,
          // ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
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
          /*DrawerHeader(
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
                Text(user.uid),
              ],
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),*/
          UserAccountsDrawerHeader(
            accountName: Text('Juan Mariñez'),
            accountEmail: Text('juan.dsmarinez@gmail.com'),
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
      },
    );
    return menuList;
  }
}
