import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Vazio extends StatefulWidget {
  Vazio({super.key, required this.statosDoQ});

  String statosDoQ;

  @override
  State<Vazio> createState() => _VazioState();
}

class _VazioState extends State<Vazio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        widget.statosDoQ,
        style: const TextStyle(color: Colors.grey, fontSize: 18),
      ),
    );
  }
}
