// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
// import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple/detailMahasiswa.dart';
import 'package:simple/koneksi.dart';
import 'package:http/http.dart' as http;

class ListMahasiswa extends StatefulWidget {
  const ListMahasiswa({super.key});

  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  Future mahasiswa() async {
    final url = Uri.parse("$koneksi/Mahasiswa/list");
    final response = await http.get(url);
    final data = json.decode(response.body);
    // debugPrint(data.toString());
    return data;
  }

  Future hapus(id_mahasiswa) async {
    final url = Uri.parse("$koneksi/Mahasiswa/hapus");
    final response =
        await http.post(url, body: {"id_mahasiswa": id_mahasiswa.toString()});
    if (response.body == "Berhasil") {
      Navigator.pop(context);
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Delete Failed',
          text: 'Gagal menghapus data',
          backgroundColor: Colors.white);
    }
    // final hasil = json.decode(response.body);
    // return hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          'List Data Mahasiswa/i',
          style: GoogleFonts.cabin(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: FutureBuilder(
                        future: mahasiswa(),
                        builder: (context, snapshot) {
                          // debugPrint(snapshot.hasData.toString());
                          return (snapshot.data.toString() == "[]")
                              ? Center(
                                  child: Text(
                                    'Belum ada data',
                                    style: GoogleFonts.cabin(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                )
                              : snapshot.hasData
                                  ? ListView.builder(
                                      itemCount: snapshot.requireData.length,
                                      itemBuilder: (context, index) {
                                        List mhs = snapshot.requireData;
                                        return Card(
                                          elevation: 8,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: ListTile(
                                              leading: const Icon(
                                                Icons.person,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              title: Center(
                                                child: Text(
                                                  mhs[index]['nama'],
                                                  style: GoogleFonts.cabin(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        title: Center(
                                                            child: Text(
                                                          'Detail Mahasiswa',
                                                          style:
                                                              GoogleFonts.cabin(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        )),
                                                        content:
                                                            DetailMahasiswa(
                                                          id_mahasiswa: mhs[
                                                                  index]
                                                              ['id_mahasiswa'],
                                                        ));
                                                  },
                                                );
                                              },
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    Widget cancelButton =
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Cancel',
                                                              style: GoogleFonts.cabin(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                            ));
                                                    Widget confirmButton =
                                                        TextButton(
                                                            onPressed: () {
                                                              hapus(mhs[index][
                                                                  'id_mahasiswa']);
                                                            },
                                                            child: Text(
                                                              'Confirm',
                                                              style: GoogleFonts.cabin(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                            ));
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            'Konfirmasi Penghapusan',
                                                            style: GoogleFonts.cabin(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .amber),
                                                          ),
                                                          content: Text(
                                                            'Yakin akan menghapus data?',
                                                            style: GoogleFonts.cabin(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          actions: [
                                                            cancelButton,
                                                            confirmButton
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: 30,
                                                    color: Colors.red,
                                                  )),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
