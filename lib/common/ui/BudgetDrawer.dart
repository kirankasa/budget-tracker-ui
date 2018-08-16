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
          DrawerHeader(
              child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Transactions"),
                leading: Icon(Icons.assignment),
                onTap: () {
                  Navigator.pushNamed(context, "/transactions");
                },
              ),
              Divider(
                color: Colors.black,
                height: 2.0,
              ),
              ListTile(
                title: Text("Categories"),
                leading: Icon(Icons.assessment),
                onTap: () {
                  Navigator.pushNamed(context, "/categories");
                },
              ),
              Divider(
                color: Colors.black,
                height: 2.0,
              ),
            ],
          )),
          ListTile(
            title: Text("Feedback"),
            leading: Icon(Icons.comment),
            onTap: () {
              Navigator.pushNamed(context, "/feedback");
            },
          ),
          ListTile(
            title: Text("Sign out"),
            leading: Icon(Icons.remove_circle),
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
