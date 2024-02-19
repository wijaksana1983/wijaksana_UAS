// ignore_for_file: use_build_context_synchronously

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple/koneksi.dart';
import 'package:http/http.dart' as http;

class AddMahasiswa extends StatefulWidget {
  const AddMahasiswa({super.key});

  @override
  State<AddMahasiswa> createState() => _AddMahasiswaState();
}

class _AddMahasiswaState extends State<AddMahasiswa> {
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

  Future tambahMhs() async {
    final url = Uri.parse("$koneksi/Mahasiswa/addData");
    final response = await http.post(url, body: {
      'nim': nim.text,
      "nama": nama.text,
      "jk": jkin,
      "tempat": tempat.text,
      "tgl": tgl.text,
      "agama": agamain,
      "telp": telp.text,
      "email": email.text,
      "jurusan": jurusan.text,
      "alamat": alamat.text,
    });
    debugPrint(response.body);
    if (response.body == "Berhasil") {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: "Success",
        text: 'Berhasil menambahkan data mahasiswa',
        backgroundColor: Colors.white,
        onConfirmBtnTap: () {
          nim.clear();
          nama.clear();
          jurusan.clear();
          tempat.clear();
          tgl.clear();
          alamat.clear();
          telp.clear();
          email.clear();
          jk.clear();
          agama.clear();
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => ListMahasiswa(),
          // ));
        },
      );
    } else {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Failed',
          text: 'Gagal menambahkan data mahasiswa',
          backgroundColor: Colors.white);
    }
    // return response;
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
          'Add Mahasiswa',
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
                          hint: const Text('Jenis Kelamin'),
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
                          hint: const Text('Agama'),
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
                                tambahMhs();
                              }
                            },
                            child: Text(
                              'Simpan',
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
