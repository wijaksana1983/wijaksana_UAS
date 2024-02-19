import 'package:flutter/material.dart';
import 'package:simple/addMahasiswa.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple/listMahasiswa.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  "MANAGEMENT MAHASISWA",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.bold)),
                ),
                const Text("Please Choice One!"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.1,
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.blue[50],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                            top: 8.0,
                            left: 8.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddMahasiswa()));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                color: Colors.blue[100],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.add_circle_outline,
                                        size: 70,
                                      ),
                                      Text(
                                        "Input Data",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ListMahasiswa()));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: MediaQuery.of(context).size.width * 0.8,
                                color: Colors.blue[100],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.list_alt_outlined,
                                        size: 70,
                                      ),
                                      Text(
                                        "View Data",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       // keluar();
                //     },
                //     icon: const Icon(
                //       Icons.exit_to_app,
                //       size: 28,
                //       color: Color.fromARGB(255, 255, 255, 255),
                //     ),
                //     label: Text("Log Out",
                //         style: GoogleFonts.poppins(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w500,
                //           color: Colors.white,
                //         )),
                //     style:
                //         ElevatedButton.styleFrom(backgroundColor: Colors.red),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
