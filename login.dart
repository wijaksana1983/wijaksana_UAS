import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple/koneksi.dart';
import 'package:http/http.dart' as http;
import 'package:simple/menu.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future cekLogin() async {
    final url = Uri.parse("$koneksi/Auth/login");
    final response = await http.post(url,
        body: {'username': username.text, 'password': password.text});
    final dataString = json.encode(response.body);

    if (username.text.isEmpty || password.text.isEmpty) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Login Failed',
          text: 'Data tidak boleh kosong',
          backgroundColor: Colors.white);
    } else {
      if (dataString.length == 0 || dataString == "false") {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: 'Login Failed',
            text: 'Username & Password salah',
            backgroundColor: Colors.white);
      } else {
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString('id_session', dataString[0]['id'].toString());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Menu(),
        ));
      }
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   // color: Colors.amber,
            //   width: MediaQuery.of(context).size.width * 0.8,
            //   height: MediaQuery.of(context).size.height * 0.2,
            //   child: Image.asset(
            //     'assets/logo.png',
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      controller: username,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.mail),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.blue,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: cekLogin,
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
