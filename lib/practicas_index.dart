import 'package:flutter/material.dart';
import 'practica1_hola.dart';
import 'practica2_boton.dart';
import 'practica3_incremental.dart';
import 'practica4_formulario.dart';
import 'rps_game.dart';
import 'drawer_widget.dart';

class PracticasIndex extends StatelessWidget {
  PracticasIndex({super.key});

  final List<Map<String, dynamic>> practicas = [
    {'titulo': 'Práctica 1: Hola Mundo', 'pantalla': const Practica1Hola()},
    {
      'titulo': 'Práctica 2: Botón 10 veces',
      'pantalla': const Practica2Boton(),
    },
    {
      'titulo': 'Práctica 3: Incremental',
      'pantalla': const Practica3Incremental(),
    },
    {
      'titulo': 'Práctica 4: Formulario',
      'pantalla': const Practica4Formulario(),
    },
    {'titulo': 'Práctica 5: Juego RPS', 'pantalla': const RpsGame()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Índice de Prácticas')),
      drawer: const AppDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: practicas.length,
        itemBuilder: (context, index) {
          final p = practicas[index];
          return Card(
            color: Colors.orange[100],
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(
                p['titulo'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[900],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => p['pantalla'] as Widget),
              ),
            ),
          );
        },
      ),
    );
  }
}
