import 'package:flutter/material.dart';
import 'dart:math';
import 'drawer_widget.dart';

class RpsGame extends StatefulWidget {
  const RpsGame({super.key});

  @override
  State<RpsGame> createState() => _RpsGameState();
}

class _RpsGameState extends State<RpsGame> {
  final Map<int, String> opciones = {0: 'Piedra', 1: 'Papel', 2: 'Tijera'};
  int usuarioScore = 0;
  int cpuScore = 0;
  String resultado = '';
  String eleccionUsuario = '';
  String eleccionCPU = '';

  void jugar(int eleccion) {
    final cpu = Random().nextInt(3);
    String res;

    if (eleccion == cpu) {
      res = 'Empate';
    } else if ((eleccion == 0 && cpu == 2) ||
        (eleccion == 1 && cpu == 0) ||
        (eleccion == 2 && cpu == 1)) {
      res = 'Ganaste';
      usuarioScore++;
    } else {
      res = 'Perdiste';
      cpuScore++;
    }

    setState(() {
      eleccionUsuario = opciones[eleccion]!;
      eleccionCPU = opciones[cpu]!;
      resultado = res;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$res! Tú: $eleccionUsuario vs CPU: $eleccionCPU'),
      ),
    );
  }

  void reiniciar() {
    setState(() {
      usuarioScore = 0;
      cpuScore = 0;
      resultado = '';
      eleccionUsuario = '';
      eleccionCPU = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Práctica 5: Juego RPS')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Marcador: Usuario $usuarioScore - CPU $cpuScore',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: opciones.entries
                  .map(
                    (e) => ElevatedButton(
                      onPressed: () => jugar(e.key),
                      child: Text(e.value),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: reiniciar,
              child: const Text('Reiniciar Marcador'),
            ),
          ],
        ),
      ),
    );
  }
}
