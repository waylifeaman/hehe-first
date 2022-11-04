// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ujikom_fiks/component/panel.dart';
import 'package:ujikom_fiks/generated_plugin_registrant.dart';
import 'package:ujikom_fiks/layout/dashboard.dart';
import 'package:ujikom_fiks/layout/register.dart';
import 'package:ujikom_fiks/rules/index.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseDatabase fireDB = FirebaseDatabase.instance;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    cekUser();
  }

  cekUser() {
    getAuth().then((value) {
      if (value.value != null) {
        navigatorPushReplace(context, page: Dashboard());
      }
    });
  }

  login() async {
    try {
      var result = await fireDB.ref('user').get();
      var data = result.children.toList().where((item) {
        if ((item.value as dynamic)['username'] == username.text) {
          return true;
        }

        return false;
      });

      if (data.isEmpty) {
        notif(context, text: 'username tidak ditemukan', color: Colors.red);
      } else {
        for (var item in data) {
          if ((item.value as dynamic)['password'] == password.text) {
            SharedPreferences session = await SharedPreferences.getInstance();
            session.setString('auth', item.key.toString());

            notif(context, text: 'berhasil login', color: Colors.white);
            navigatorPushReplace(context, page: Dashboard());
            return true;
          }
        }

        notif(context, text: 'password salah', color: Colors.red);
      }
    } catch (e) {
      notif(context, text: e.toString(), color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Hello Cuy', style: GoogleFonts.bebasNeue(fontSize: 40)),
              Text(
                'Selamat Datang, Silahkan login terlebihh dahulu',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8),
              //   child: Image.asset(
              //     "assets/img/flutter.png",
              //     height: 100,
              //     width: 100,
              //   ),
              // ),

              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  // ignore: deprecated_member_use
                  onTap: () {
                    login();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'belum mempunyai akun?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Register())));
                    },
                    child: Text(
                      'Daftar Sekarang',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.grey[300],
    primary: Colors.blue[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ));

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Container(
//               height: size.height * .45,
//               width: size.width,
//               color: cPrimary,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   SizedBox(height: size.height * .2),
//                   Panel(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//                     child: Column(
//                       children: [
//                         Text(
//                           'LOGIN',
//                           style: TextStyle(
//                               color: cPrimary,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: 40),
//                         TextFormField(
//                           controller: username,
//                           decoration: InputDecoration(
//                             hintText: 'Username anda',
//                             label: Text('Username'),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           controller: password,
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             hintText: 'Password anda',
//                             label: Text('Password'),
//                           ),
//                         ),
//                         SizedBox(height: 40),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(5),
//                           child: Container(
//                             color: cPrimary,
//                             child: Material(
//                               color: Colors.transparent,
//                               child: InkWell(
//                                 onTap: login,
//                                 child: Container(
//                                   padding: EdgeInsets.all(20),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     'LOGIN',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text('Belum punya akun? register '),
//                             GestureDetector(
//                               onTap: () {
//                                 navigatorPushReplace(context, page: Register());
//                               },
//                               child: Text(
//                                 'disini',
//                                 style: TextStyle(color: cPrimary),
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
