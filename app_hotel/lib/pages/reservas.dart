import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Reservas extends StatefulWidget {
  const Reservas({super.key});

  @override
  State<Reservas> createState() => _ReservasState();
}

Future<File> _getFile() async {
  final diretorio = await getApplicationDocumentsDirectory();
  return File('${diretorio.path}/listareservas.json');
}

Future<dynamic> _lerArquivo() async {
  final arquivo = await _getFile();
  return arquivo.readAsStringSync();
}

const corback = Color.fromARGB(255, 131, 3, 3);
const corLetra = Color.fromARGB(255, 255, 196, 34);
final dataAtual = DateFormat.yMMMMd("pt_BR").format(DateTime.now());
List<Map<String, dynamic>> listaReservas = [];
List<Map<String, dynamic>> listaReservas2 = [];
TextEditingController control = TextEditingController();
bool erroText = false;

class _ReservasState extends State<Reservas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Reservas",
            style: TextStyle(color: corLetra, fontSize: 23),
          ),
          backgroundColor: corback,
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _lerArquivo(),
            builder: (context, snapshot) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 15,
                      ),
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 40),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3))
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: TextField(
                                  controller: control,
                                  onSubmitted: (el) {
                                    criarReserva(snapshot.hasData);
                                    control.text = "";
                                  },
                                  decoration: InputDecoration(
                                      errorText:
                                          erroText ? "Campo vazio !" : null,
                                      border: InputBorder.none,
                                      hintText: "Nome do hóspede",
                                      hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400)))),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 15),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(30, 30),
                                    backgroundColor: corback,
                                    padding: const EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                onPressed: () {
                                  _salvarquivo();
                                  criarReserva(snapshot.hasData);
                                  control.text = "";
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: corLetra,
                                )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        for (Map<String, dynamic> el in snapshot.hasData
                            ? recupdados(jsonDecode(snapshot.data))
                            : listaReservas)
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3))
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    const Color.fromARGB(255, 250, 254, 255)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      el["nome"],
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(el["data"],
                                        style: const TextStyle(
                                          fontSize: 13,
                                        ))
                                  ],
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: corback,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                    onPressed: () {
                                      for (var i = 0;
                                          i < listaReservas.length;
                                          i++) {
                                        if (listaReservas[i]["nome"] ==
                                            el["nome"]) {
                                          setState(() {
                                            listaReservas.removeAt(i);
                                            print(listaReservas);
                                          });
                                        }
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete_forever_rounded,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          )
                      ],
                    ))
                  ],
                ),
              );
            }));
  }

  criarReserva(el) {
    if (control.text == "") {
      setState(() {
        erroText = true;
      });
    } else {
      if (el) {
        var reserva = {"nome": control.text, "data": dataAtual};
        setState(() {
          erroText = false;
          listaReservas2.add(reserva);
        });
      } else {
        var reserva = {"nome": control.text, "data": dataAtual};
        setState(() {
          erroText = false;
          listaReservas.add(reserva);
        });
      }
    }
  }

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File('${diretorio.path}/listareservas.json');
  }

// ignore: unused_element
  _salvarquivo() async {
    var arquivo = await _getFile();
    // ignore: avoid_print
    print("item salvo");

    String dadosjason = json.encode(listaReservas);
    arquivo.writeAsStringSync(dadosjason);
  }

  recupdados(el) {
    List<dynamic> dadosrecebidos = el;
    List<Map<String, dynamic>> maprec = dadosrecebidos.map((el) {
      return Map<String, dynamic>.from(el);
    }).toList();
    listaReservas2 = maprec;
    return listaReservas2;
  }

  @override
  void initState() {
    // TODO: implement initState
    _lerArquivo();
    super.initState();
  }
}
