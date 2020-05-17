import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marinez_demo/app/screens/home/form_page.dart';
import 'package:marinez_demo/services/menu_provider.dart';
import 'package:marinez_demo/components/menu_option.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios Express'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.inbox,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pushNamed(context, 'pending'),
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
        imageData: option['image'],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPage(
                title: option['title'],
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
