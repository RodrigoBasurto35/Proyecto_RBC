import 'package:flutter/material.dart';
import 'drawer_widget.dart';

class Practica1Hola extends StatelessWidget {
  const Practica1Hola({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Práctica 1: Hola Mundo')),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          '¡Hola Mundo!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
