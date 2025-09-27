import 'package:flutter/material.dart';
import 'drawer_widget.dart';

class Practica2Boton extends StatefulWidget {
  const Practica2Boton({super.key});

  @override
  State<Practica2Boton> createState() => _Practica2BotonState();
}

class _Practica2BotonState extends State<Practica2Boton> {
  List<String> mensajes = [];

  void mostrarHola() {
    setState(() {
      mensajes = List.generate(10, (index) => 'Hola Mundo ${index + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Práctica 2: Botón 10 veces')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: mostrarHola,
              child: const Text('Mostrar Hola Mundo'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: mensajes
                    .map(
                      (e) => Text(
                        e,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
