import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';

class BudgetDrawer extends StatelessWidget {
  String userName;
  String email;
  BudgetDrawer({this.email, this.userName});
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              accountName: new Text(userName), accountEmail: new Text(email)),
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
          ),
          new Divider(
            color: Colors.black,
            height: 2.0,
          ),
          new ListTile(
            title: new Text("Sign out"),
            leading: new Icon(Icons.delete_forever),
            onTap: () {
              SharedPreferencesHelper.removeToken();
              Navigator.pushNamed(context, "/login");
            },
          )
        ],
      ),
    );
  }
}
