// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple/editMahasiswa.dart';
import 'package:simple/koneksi.dart';
import 'package:http/http.dart' as http;

class DetailMahasiswa extends StatefulWidget {
  DetailMahasiswa({required this.id_mahasiswa});

  int id_mahasiswa;
  @override
  State<DetailMahasiswa> createState() => _DetailMahasiswaState();
}

class _DetailMahasiswaState extends State<DetailMahasiswa> {
  Future detail() async {
    debugPrint(widget.id_mahasiswa.toString());
    final url = Uri.parse("$koneksi/Mahasiswa/detail");
    final response = await http
        .post(url, body: {"id_mahasiswa": widget.id_mahasiswa.toString()});
    final detail = json.decode(response.body);
    debugPrint(detail.toString());

    return detail;
  }

  // Future detail() async {
  //   final url = Uri.parse(
  //       "$koneksi/Mahasiswa/detail?id_mahasiswa=${widget.id_mahasiswa}");
  //   final response = await http.get(url);
  //   final detail = json.decode(response.body);

  //   // debugPrint(detail);
  //   return detail;
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              child: FutureBuilder<dynamic>(
                future: detail(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.requireData.length,
                          itemBuilder: (context, index) {
                            List detail = snapshot.requireData;
                            return Form(
                                child: Column(
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'NIM',
                                      labelStyle: TextStyle(
                                        fontFamily: 'cabin',
                                        color: Colors.grey,
                                      )),
                                  controller: TextEditingController(
                                    text: detail[index]['nim'],
                                  ),
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Nama Mahasiswa',
                                      labelStyle: TextStyle(
                                        fontFamily: 'cabin',
                                        color: Colors.grey,
                                      )),
                                  controller: TextEditingController(
                                    text: detail[index]['nama'],
                                  ),
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Jenis Kelamin',
                                      labelStyle: TextStyle(
                                        fontFamily: 'cabin',
                                        color: Colors.grey,
                                      )),
                                  controller: TextEditingController(
                                    text: detail[index]['jk'],
                                  ),
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Agama',
                                      labelStyle: TextStyle(
                                        fontFamily: 'cabin',
                                        color: Colors.grey,
                                      )),
                                  controller: TextEditingController(
                                    text: detail[index]['agama'],
                                  ),
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Tempat Tanggal Lahir',
                                      labelStyle: TextStyle(
                                        fontFamily: 'cabin',
                                        color: Colors.grey,
                                      )),
                                  controller: TextEditingController(
                                    text: detail[index]['tempat'] +
                                        ', ' +
                                        DateFormat.yMMMd('en_US').format(
                                            DateTime.parse(
                                                detail[index]['tgl'])),
                                  ),
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Nomor Telepon',
                                      labelStyle: TextStyle(
                                        fontFamily: 'cabin',
                                        color: Colors.grey,
                                      )),
                                  controller: TextEditingController(
                                    text: detail[index]['telp'],
                                  ),
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        fontFamily: 'cabin',
                                        color: Colors.grey,
                                      )),
                                  controller: TextEditingController(
                                    text: detail[index]['email'],
                                  ),
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                TextFormField(
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Alamat',
                                      labelStyle: TextStyle(
                                        fontFamily: 'cabin',
                                        color: Colors.grey,
                                      )),
                                  controller: TextEditingController(
                                    text: detail[index]['alamat'],
                                  ),
                                  style: GoogleFonts.cabin(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ));
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                },
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            // color: Colors.blue,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                // lalu = true;
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => LogbookOld(
                //     tgl: widget.tgl,
                //     id_absen: id_absen,
                //     lalu: lalu,
                //   ),
                // ));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        EditMahasiswa(id_mahasiswa: widget.id_mahasiswa)));
              },
              icon: const Icon(
                Icons.edit,
                size: 16,
                color: Colors.white,
              ),
              label: Text(
                'Edit Mahasiswa',
                style: GoogleFonts.cabin(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
