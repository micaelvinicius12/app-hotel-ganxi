import 'package:app_hotel/pages/componente/criarAndar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Paginap extends StatefulWidget {
  Paginap({
    super.key,
    required this.todosQ,
    required this.corAusente,
    required this.corDisponivel,
    required this.corOcupado,
    required this.corBack,
    required this.corLetra,
  });

  List<Map<String, dynamic>> todosQ;
  Color corDisponivel;
  Color corOcupado;
  Color corAusente;
  Color corBack;
  Color corLetra;

  @override
  State<Paginap> createState() => _PaginapState();
}

class _PaginapState extends State<Paginap> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          for (Map<String, dynamic> el in widget.todosQ)
            if (int.parse(el["titulo"]) >= 300 &&
                int.parse(el["titulo"]) <= 312)
              Criarandar(
                  todosQ: widget.todosQ,
                  corAusente: widget.corAusente,
                  corDisponivel: widget.corDisponivel,
                  corOcupado: widget.corOcupado,
                  corBack: widget.corBack,
                  corLetra: widget.corLetra,
                  elemento: el),
          Container(
            width: 400,
            height: 50,
            margin: const EdgeInsets.only(top: 30, bottom: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.corBack,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ],
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(10),
            child: const Text(
              "2 Andar",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 196, 34),
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
          for (Map<String, dynamic> el in widget.todosQ)
            if (int.parse(el["titulo"]) >= 200 &&
                int.parse(el["titulo"]) <= 212)
              Criarandar(
                  todosQ: widget.todosQ,
                  corAusente: widget.corAusente,
                  corDisponivel: widget.corDisponivel,
                  corOcupado: widget.corOcupado,
                  corBack: widget.corBack,
                  corLetra: widget.corLetra,
                  elemento: el),
          Container(
            width: 400,
            height: 50,
            margin: const EdgeInsets.only(top: 30, bottom: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.corBack,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ],
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(10),
            child: const Text(
              "1 Andar",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 196, 34),
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
          for (Map<String, dynamic> el in widget.todosQ)
            if (int.parse(el["titulo"]) <= 112)
              Criarandar(
                  todosQ: widget.todosQ,
                  corAusente: widget.corAusente,
                  corDisponivel: widget.corDisponivel,
                  corOcupado: widget.corOcupado,
                  corBack: widget.corBack,
                  corLetra: widget.corLetra,
                  elemento: el),
        ],
      ),
    );
  }
}
