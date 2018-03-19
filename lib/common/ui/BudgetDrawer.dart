import 'package:flutter/material.dart';

class BudgetDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              accountName: new Text("kiranreddykasa"),
              accountEmail: new Text("kiranreddy2004@gmail.com")),
          new DrawerHeader(
              child: new ListView(
            children: <Widget>[
              new ListTile(
                title: new Text("Transactions"),
                leading: new Icon(Icons.assignment),
                onTap: () {
                  Navigator.pushNamed(context, "/transactions");
                },
              ),
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
              new ListTile(
                title: new Text("Categories"),
                leading: new Icon(Icons.assessment),
                onTap: () {
                  Navigator.pushNamed(context, "/categories");
                },
              ),
              new Divider(
                color: Colors.black,
                height: 2.0,
              ),
            ],
          )),
          new AboutListTile(
            applicationName: "Budget tracker",
            applicationVersion: "1.0",
            applicationIcon: new Icon(Icons.supervisor_account),
          )
        ],
      ),
    );
  }
}
