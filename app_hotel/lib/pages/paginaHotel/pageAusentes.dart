import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class Ausentes extends StatefulWidget {
  Ausentes({
    super.key,
    required this.corDisponivel,
    required this.corOcupado,
    required this.corausente,
    required this.quartosAusentes,
  });

  Color corDisponivel;
  Color corOcupado;
  Color corausente;
  List<Map<String, dynamic>> quartosAusentes;

  @override
  State<Ausentes> createState() => _AusentesState();
}

class _AusentesState extends State<Ausentes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          for (Map<String, dynamic> el in vericaDisponivel())
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                        title: const Text('Qual a situação do quarto ?'),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.corOcupado,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              onPressed: () {
                                _salvarquivo();
                                setState(() {
                                  el["cor"] = 2;
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text(
                                'Ocupado',
                                style: TextStyle(color: Colors.white),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.corDisponivel,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              onPressed: () {
                                _salvarquivo();
                                setState(() {
                                  el["cor"] = 0;
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('Disponivel',
                                  style: TextStyle(color: Colors.white))),
                        ],
                      );
                    });
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3))
                    ]),
                alignment: Alignment.center,
                child: Text(
                  el["titulo"],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
        ],
      ),
    );
  }

  vericaDisponivel() {
    List<Map<String, dynamic>> dadosOut = [];
    for (Map<String, dynamic> el in widget.quartosAusentes) {
      if (el["cor"] == 1) {
        dadosOut.add(el);
      }
    }
    return dadosOut;
  }

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File('${diretorio.path}/dados.json');
  }

// ignore: unused_element
  _salvarquivo() async {
    var arquivo = await _getFile();
    print("item salvo");

    String dadosjason = json.encode(widget.quartosAusentes);
    arquivo.writeAsStringSync(dadosjason);
  }
}
