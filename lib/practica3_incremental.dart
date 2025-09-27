import 'package:flutter/material.dart';
import 'drawer_widget.dart';

class Practica3Incremental extends StatefulWidget {
  const Practica3Incremental({super.key});

  @override
  State<Practica3Incremental> createState() => _Practica3IncrementalState();
}

class _Practica3IncrementalState extends State<Practica3Incremental> {
  List<String> mensajes = [];

  void agregarHola() {
    setState(() {
      mensajes.add('Hola Mundo ${mensajes.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Práctica 3: Incremental')),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: mensajes
                  .map(
                    (e) => Text(
                      e,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[900],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: agregarHola,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
