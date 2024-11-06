import 'dart:convert';
import 'dart:io';
import 'package:app_hotel/pages/paginaHotel/pageDisponivel.dart';
import 'package:app_hotel/pages/paginaHotel/pageAusentes.dart';
import 'package:app_hotel/pages/paginaHotel/pageOcupado.dart';
import 'package:app_hotel/pages/paginaHotel/pageVazio.dart';
import 'package:app_hotel/pages/paginaHotel/paginaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Hotel extends StatefulWidget {
  const Hotel({super.key});

  @override
  State<Hotel> createState() => _HotelState();
}

const corback = Color.fromARGB(255, 131, 3, 3);
const corLetra = Color.fromARGB(255, 255, 196, 34);
const corDisponivel = Colors.green;
const corOcupado = Colors.red;
const corAusente = Colors.orange;
final dataAtual = DateFormat.yMMMMd("pt_BR").format(DateTime.now());
var telas = 0;

Future<File> _getFile() async {
  final diretorio = await getApplicationDocumentsDirectory();
  return File('${diretorio.path}/dados.json');
}

List<Map<String, dynamic>>? quartos2;
List<Map<String, dynamic>> quartos = [
  {"titulo": "101", "cor": 0},
  {"titulo": "102", "cor": 0},
  {"titulo": "103", "cor": 0},
  {"titulo": "104", "cor": 0},
  {"titulo": "105", "cor": 0},
  {"titulo": "106", "cor": 0},
  {"titulo": "107", "cor": 0},
  {"titulo": "108", "cor": 0},
  {"titulo": "109", "cor": 0},
  {"titulo": "110", "cor": 0},
  {"titulo": "111", "cor": 0},
  {"titulo": "112", "cor": 0},
  {"titulo": "201", "cor": 0},
  {"titulo": "202", "cor": 0},
  {"titulo": "203", "cor": 0},
  {"titulo": "204", "cor": 0},
  {"titulo": "205", "cor": 0},
  {"titulo": "206", "cor": 0},
  {"titulo": "207", "cor": 0},
  {"titulo": "208", "cor": 0},
  {"titulo": "209", "cor": 0},
  {"titulo": "210", "cor": 0},
  {"titulo": "211", "cor": 0},
  {"titulo": "212", "cor": 0},
  {"titulo": "301", "cor": 0},
  {"titulo": "302", "cor": 0},
  {"titulo": "303", "cor": 0},
  {"titulo": "304", "cor": 0},
  {"titulo": "305", "cor": 0},
  {"titulo": "306", "cor": 0},
  {"titulo": "307", "cor": 0},
  {"titulo": "308", "cor": 0},
  {"titulo": "309", "cor": 0},
  {"titulo": "310", "cor": 0},
  {"titulo": "311", "cor": 0},
  {"titulo": "312", "cor": 0},
];

// ignore: unused_element
_salvarquivo() async {
  var arquivo = await _getFile();
  // ignore: avoid_print
  // print("item salvo");

  String dadosjason = json.encode(quartos);
  arquivo.writeAsStringSync(dadosjason);
}

// ignore: unused_element
Future<dynamic> _lerArquivo() async {
  try {
    final arquivo = await _getFile();
    return arquivo.readAsStringSync();
  } catch (e) {
    _salvarquivo();
    final arquivo = await _getFile();
    return arquivo.readAsStringSync();
  }
}

verificaCor(el) {
  if (el == 0) {
    return corDisponivel;
  } else if (el == 1) {
    return corAusente;
  } else if (el == 2) {
    return corOcupado;
  }
}

layauts(List<Map<String, dynamic>> el) {
  switch (telas) {
    case 0:
      return Paginap(
        todosQ: el,
        corAusente: corAusente,
        corBack: corback,
        corDisponivel: corDisponivel,
        corLetra: corLetra,
        corOcupado: corOcupado,
      );

      // ignore: dead_code
      break;
    case 1:
      return Ausentes(
          corDisponivel: corDisponivel,
          corOcupado: corOcupado,
          corausente: corAusente,
          quartosAusentes: el);
      // ignore: dead_code
      break;
    case 2:
      return Ocupado(
          corDisponivel: corDisponivel,
          corOcupado: corOcupado,
          corausente: corAusente,
          quartosOcupado: el);
      // ignore: dead_code
      break;
    case 3:
      return Disponivel(
          corDisponivel: corDisponivel,
          corOcupado: corOcupado,
          corausente: corAusente,
          quartosDisponivel: el);

      // ignore: dead_code
      break;
    case 4:
      return Vazio(statosDoQ: "Não há quartos ocupados");
      // ignore: dead_code
      break;
    case 5:
      return Vazio(statosDoQ: "Não há quartos ausentes");
      // ignore: dead_code
      break;
    case 6:
      return Vazio(statosDoQ: "Não há quartos disponivel");
      // ignore: dead_code
      break;
  }
}

/*
Future<List<Map<String, dynamic>>> start() async {

}
*/
class _HotelState extends State<Hotel> {
  @override
  void initState() {
    super.initState();
    _lerArquivo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  telas = 0;
                });
              },
              child: const Text(
                "ALL",
                style: TextStyle(
                    color: corLetra, fontSize: 15, fontWeight: FontWeight.w700),
              ),
            )
          ],
          title: const Text(
            "Quartos",
            style: TextStyle(color: corLetra, fontSize: 21),
          ),
          centerTitle: true,
          backgroundColor: corback,
        ),
        body: FutureBuilder<dynamic>(
            future: _lerArquivo(),
            builder: (context, snapshot) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: corDisponivel))),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (vericaDisponivel(0)) {
                                  telas = 3;
                                } else {
                                  telas = 6;
                                }
                              });
                            },
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text("Disponivel",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(width: 2, color: corOcupado))),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (vericaDisponivel(2)) {
                                    telas = 2;
                                  } else {
                                    telas = 4;
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                "Ocupado",
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(width: 2, color: corAusente))),
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (vericaDisponivel(1)) {
                                    telas = 1;
                                  } else {
                                    telas = 5;
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("Ausente",
                                  style: TextStyle(color: Colors.grey))),
                        )
                      ],
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, left: 25),
                          child: Text(
                            dataAtual,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                        layauts(snapshot.hasData
                            ? recupdados(json.decode(snapshot.data))
                            : quartos)
                      ],
                    ))
                  ],
                ),
              );
            }));
  }

  vericaDisponivel(ele) {
    List<Map<String, dynamic>> dadosOut = [];
    for (Map<String, dynamic> el in quartos2!) {
      if (el["cor"] == ele) {
        dadosOut.add(el);
      }
    }
    return dadosOut.isNotEmpty;
  }

  recupdados(el) {
    List<dynamic> dadosrecebidos = el;
    List<Map<String, dynamic>> maprec = dadosrecebidos.map((el) {
      return Map<String, dynamic>.from(el);
    }).toList();
    quartos2 = maprec;
    return quartos2;
  }
}
