import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';

class BudgetDrawer extends StatelessWidget {
  final String userName;
  final String email;

  BudgetDrawer({this.email, this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(userName), accountEmail: Text(email)),
          ListTile(
            title: Text("Transactions"),
            leading: Icon(Icons.assignment),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, "/transactions", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Categories"),
            leading: Icon(Icons.apps),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, "/categories", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Chart"),
            leading: Icon(Icons.insert_chart),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, "/chart", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Feedback"),
            leading: Icon(Icons.comment),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, "/feedback", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Sign out"),
            leading: Icon(Icons.remove_circle),
            onTap: () {
              SharedPreferencesHelper.removeToken();
              Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
