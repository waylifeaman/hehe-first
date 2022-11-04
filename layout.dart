import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:ujikom_fiks/component/panel.dart';
import 'package:ujikom_fiks/layout/login.dart';
import 'package:ujikom_fiks/layout/profil.dart';
import 'package:ujikom_fiks/layout/user.dart';
import 'package:ujikom_fiks/rules/index.dart';
import 'dashboard.dart';

class Layout extends StatefulWidget {
  const Layout({
    Key? key,
    this.body,
    this.title,
    this.floatingActionButton,
  }) : super(key: key);

  final Widget? body;
  final String? title;
  final Widget? floatingActionButton;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  String userUsername = '';
  String userNama = '';
  String userRole = '';

  @override
  void initState() {
    super.initState();
    cekUser();
  }

  void cekUser() {
    getAuth().then((value) {
      if (value.value != null) {
        setState(() {
          userUsername = value.value['username'];
          userNama = value.value['nama'];
          userRole = value.value['role'];
        });
      }
    });
  }

  logout() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    await session.clear();

    navigatorPushReplace(context, page: Login());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * .25,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
          widget.body as Widget,
        ],
      ),
      floatingActionButton: widget.floatingActionButton,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: cPrimary,
                      size: 30,
                    )
                  ],
                ),
              ),
              accountName: Text(userUsername),
              accountEmail: Text(userNama),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              onTap: () {
                navigatorPush(context, page: Dashboard());
              },
            ),
            userRole == '1'
                ? ListTile(
                    leading: Icon(Icons.supervisor_account),
                    title: Text('Data User'),
                    onTap: () {
                      navigatorPush(context, page: User());
                    },
                  )
                : SizedBox(),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profil'),
              onTap: () {
                navigatorPush(context, page: Profil());
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      content: Text("Anda yakin akan logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            navigatorPop(context);
                          },
                          child: Text('BATAL'),
                        ),
                        TextButton(
                          onPressed: logout,
                          child: Text('LOGOUT'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
