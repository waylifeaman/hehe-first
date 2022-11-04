// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ujikom_fiks/component/panel.dart';
import 'package:ujikom_fiks/layout/login.dart';
import 'package:ujikom_fiks/layout/user.dart';
import 'package:ujikom_fiks/rules/index.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseDatabase fireDB = FirebaseDatabase.instance;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController nomorTelepon = TextEditingController();
  TextEditingController alamat = TextEditingController();

  register() async {
    try {
      var result = await fireDB.ref('user').get();
      var data = result.children.toList().where((item) {
        if ((item.value as dynamic)['username'] == username.text) {
          return true;
        }
        return false;
      });

      if (data.isEmpty) {
        await fireDB.ref('user').push().set({
          'username': username.text,
          'nama': nama.text,
          'password': password.text,
          'nomorTelepon': nomorTelepon.text,
          'alamat': alamat.text,
          'role': '2',
        }).then((value) {
          notif(context,
              text: 'registrasi akun berhasil. silahkan login!',
              color: Colors.white);
          navigatorPushReplace(context, page: Login());
        });
      } else {
        notif(context, text: 'username sudah digunakan', color: Colors.red);
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
                'Silahkan Masukkan Data Anda',
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
                height: 10,
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
                    hintText: 'username',
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
                  controller: nama,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    hintText: 'Nama',
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
                  controller: password,
                  obscureText: true,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: nomorTelepon,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    hintText: 'no telpon',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: alamat,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    hintText: 'alamat',
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
                    register();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(
                      'Daftar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Login())));
                    },
                    child: Text(
                      'Kembali Login',
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
//                   SizedBox(height: size.height * .15),
//                   Panel(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//                     child: Column(
//                       children: [
//                         Text(
//                           'REGISTER',
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
//                             hintText: '********',
//                             label: Text('Password'),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           controller: nama,
//                           decoration: InputDecoration(
//                             hintText: 'Nama anda',
//                             label: Text('Nama'),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           controller: nomorTelepon,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             hintText: '62xxxxxxxxx',
//                             label: Text('Nomor Telepon'),
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
//                                 onTap: register,
//                                 child: Container(
//                                   padding: EdgeInsets.all(20),
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     'REGISTER',
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
//                             Text('Sudah punya akun? login '),
//                             GestureDetector(
//                               onTap: () {
//                                 navigatorPushReplace(context, page: Login());
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
