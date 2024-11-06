import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class Criarandar extends StatefulWidget {
  Criarandar({
    super.key,
    required this.todosQ,
    required this.corAusente,
    required this.corDisponivel,
    required this.corOcupado,
    required this.corBack,
    required this.corLetra,
    required this.elemento,
  });

  List<Map<String, dynamic>> todosQ;
  Color corDisponivel;
  Color corOcupado;
  Color corAusente;
  Color corBack;
  Color corLetra;
  Map<String, dynamic> elemento;

  @override
  State<Criarandar> createState() => _CriarandarState();
}

class _CriarandarState extends State<Criarandar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                title: const Text('Qual a situação do quarto ?'),
                alignment: Alignment.center,
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
                          widget.elemento["cor"] = 2; //atualiza lista /////
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
                          widget.elemento["cor"] = 0; //atualiza lista /////
                          Navigator.pop(context);
                        });
                      },
                      child: const Text('Disp.',
                          style: TextStyle(color: Colors.white))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.corAusente,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      onPressed: () {
                        _salvarquivo();
                        setState(() {
                          widget.elemento["cor"] = 1; //atualiza lista /////
                          Navigator.pop(context);
                        });
                      },
                      child: const Text('Ausente',
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
            color: verificaCor(widget.elemento["cor"]),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
        alignment: Alignment.center,
        child: Text(
          widget.elemento["titulo"],
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  verificaCor(el) {
    if (el == 0) {
      return widget.corDisponivel;
    } else if (el == 1) {
      return widget.corAusente;
    } else if (el == 2) {
      return widget.corOcupado;
    }
  }

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File('${diretorio.path}/dados.json');
  }

// ignore: unused_element
  _salvarquivo() async {
    var arquivo = await _getFile();
    // ignore: avoid_print
    // print("item salvo");

    String dadosjason = json.encode(widget.todosQ);
    arquivo.writeAsStringSync(dadosjason);
  }
}
