import 'package:flutter/material.dart';
import 'package:summer_home/resources/auth_methods.dart';

class AppDrawer extends StatelessWidget {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
              color: Color.fromRGBO(54, 169, 186, 1.0),
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Welcome To Age Well",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
              )),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Signout'),
              onTap: () {
                _authMethods.signOut();
              }),
          Divider(),
        ],
      ),
    );
  }
}
