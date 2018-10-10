import 'package:budget_tracker/common/SharedPreferencesHelper.dart';
import 'package:budget_tracker/user/User.dart';
import 'package:flutter/material.dart';

class BudgetDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      builder: ((BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return drawer(context, snapshot.data.email, snapshot.data.userName);
        } else {
          return drawer(context, "", "");
        }
      }),
      future: SharedPreferencesHelper.getLoggedInValue(),
    );
  }

  Widget drawer(BuildContext context, String email, String userName) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(userName), accountEmail: Text(email)),
          ListTile(
            title: Text("Transactions"),
            leading: Icon(Icons.assignment),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/transactions", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Categories"),
            leading: Icon(Icons.apps),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/categories", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Chart"),
            leading: Icon(Icons.insert_chart),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/chart", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Feedback"),
            leading: Icon(Icons.comment),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/feedback", (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text("Sign out"),
            leading: Icon(Icons.remove_circle),
            onTap: () {
              SharedPreferencesHelper.removeToken();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
