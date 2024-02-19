// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple/koneksi.dart';
import 'package:http/http.dart' as http;
import 'package:simple/menu.dart';

class EditMahasiswa extends StatefulWidget {
  EditMahasiswa({required this.id_mahasiswa, super.key});

  int id_mahasiswa;
  @override
  State<EditMahasiswa> createState() => _EditMahasiswaState();
}

class _EditMahasiswaState extends State<EditMahasiswa> {
  TextEditingController nim = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController jurusan = TextEditingController();
  TextEditingController tempat = TextEditingController();
  TextEditingController tgl = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController telp = TextEditingController();
  TextEditingController email = TextEditingController();

  List<DropdownMenuItem<String>> jk = [
    const DropdownMenuItem(value: 'Pria', child: Text('Pria')),
    const DropdownMenuItem(value: 'Wanita', child: Text('Wanita')),
  ];

  List<DropdownMenuItem<String>> agama = [
    const DropdownMenuItem(value: 'Islam', child: Text('Islam')),
    const DropdownMenuItem(value: 'Kristen', child: Text('Kristen')),
    const DropdownMenuItem(value: 'Katolik', child: Text('Katolik')),
    const DropdownMenuItem(value: 'Hindu', child: Text('Hindu')),
    const DropdownMenuItem(value: 'Budha', child: Text('Budha')),
    const DropdownMenuItem(value: 'Kong Hu Chu', child: Text('Kong Hu Chu')),
  ];

  String jkin = '';
  String agamain = '';

  Future ubahMhs() async {
    final url = Uri.parse("$koneksi/Mahasiswa/ubah");
    final response = await http.post(url, body: {
      "id_mahasiswa": widget.id_mahasiswa.toString(),
      "nim": nim.text,
      "nama": nama.text,
      "jurusan": jurusan.text,
      "tempat": tempat.text,
      "tgl": tgl.text,
      "alamat": alamat.text,
      "telp": telp.text,
      "email": email.text,
      "agama": agamain,
      "jk": jkin
    });
    if (response.body == "Berhasil") {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: "Success",
        text: "Berhasil mengubah data mahasiswa",
        backgroundColor: Colors.white,
        onConfirmBtnTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Menu(),
          ));
        },
      );
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Failed",
          text: "Gagal mengubah data mahasiswa",
          backgroundColor: Colors.white);
    }
  }

  Future edit() async {
    final url = Uri.parse("$koneksi/Mahasiswa/detail");
    final response = await http
        .post(url, body: {"id_mahasiswa": widget.id_mahasiswa.toString()});
    final edit = json.decode(response.body);
    setState(() {
      nim.text = edit[0]['nim'];
      nama.text = edit[0]['nama'];
      jurusan.text = edit[0]['jurusan'];
      tempat.text = edit[0]['tempat'];
      tgl.text = edit[0]['tgl'];
      alamat.text = edit[0]['alamat'];
      telp.text = edit[0]['telp'];
      email.text = edit[0]['email'];
      agamain = edit[0]['agama'];
      jkin = edit[0]['jk'];
    });

    return edit;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    edit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.blue,
        ),
        title: Text(
          'Edit Mahasiswa',
          style: GoogleFonts.cabin(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                        child: Column(
                      children: [
                        TextFormField(
                          maxLines: 1,
                          controller: nim,
                          decoration: const InputDecoration(
                            labelText: 'NIM',
                          ),
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: nama,
                          decoration: const InputDecoration(
                            labelText: 'Nama Mahasiswa',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          hint: jkin == ""
                              ? const Text('Jenis Kelamin')
                              : Text(jkin),
                          items: jk,
                          onChanged: (value) {
                            setState(() {
                              jkin = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          hint: agamain == ""
                              ? const Text('Agama')
                              : Text(agamain),
                          items: agama,
                          onChanged: (value) {
                            setState(() {
                              agamain = value!;
                            });
                          },
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: jurusan,
                          decoration: const InputDecoration(
                            labelText: 'Jurusan',
                          ),
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: tempat,
                          decoration: const InputDecoration(
                            labelText: 'Tempat Lahir',
                          ),
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: tgl,
                          decoration: const InputDecoration(
                            labelText: 'Tanggal Lahir',
                          ),
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: telp,
                          decoration: const InputDecoration(
                            labelText: 'Nomor HP',
                          ),
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: email,
                          decoration: const InputDecoration(
                            labelText: 'email',
                          ),
                        ),
                        TextFormField(
                          maxLines: 3,
                          controller: alamat,
                          decoration: const InputDecoration(
                            labelText: 'Alamat',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: TextButton(
                            onPressed: () {
                              if (nim.text.isEmpty ||
                                  nama.text.isEmpty ||
                                  jkin == '' ||
                                  tempat.text.isEmpty ||
                                  tgl.text.isEmpty ||
                                  agamain == '' ||
                                  telp.text.isEmpty ||
                                  email.text.isEmpty ||
                                  jurusan.text.isEmpty ||
                                  alamat.text.isEmpty) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: 'Semua data harus terisi',
                                );
                              } else {
                                ubahMhs();
                              }
                            },
                            child: Text(
                              'Ubah',
                              style: GoogleFonts.cabin(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
