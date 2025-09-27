import 'package:flutter/material.dart';
import 'dart:math';
import 'drawer_widget.dart';

class KitOffline extends StatefulWidget {
  const KitOffline({super.key});

  @override
  State<KitOffline> createState() => _KitOfflineState();
}

class _KitOfflineState extends State<KitOffline> {
  int _selectedModule = -1; // -1 = mostrar menú principal

  // ==== Datos Notas, IMC, Galería, Par/Impar ====
  List<String> notas = [];
  final TextEditingController notaCtrl = TextEditingController();
  final TextEditingController estaturaCtrl = TextEditingController();
  final TextEditingController pesoCtrl = TextEditingController();
  final _imcKey = GlobalKey<FormState>();

  final List<String> imagenes = [
    'assets/images/img1.png',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
  ];

  int usuarioScore = 0;
  int cpuScore = 0;
  String resultadoPI = '';
  int? eleccionUsuario;

  // ==== Funciones ====
  void abrirModulo(int index) => setState(() => _selectedModule = index);
  void volverMenu() => setState(() => _selectedModule = -1);

  // Notas
  void agregarNota() {
    if (notaCtrl.text.isNotEmpty) {
      setState(() => notas.add(notaCtrl.text));
      notaCtrl.clear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nota agregada')));
    }
  }

  void borrarNotas() {
    setState(() => notas.clear());
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Todas las notas borradas')));
  }

  // IMC
  void calcularIMC() {
    if (_imcKey.currentState!.validate()) {
      final est = double.parse(estaturaCtrl.text);
      final kg = double.parse(pesoCtrl.text);
      final imc = kg / (est * est);
      String cat;
      if (imc < 18.5)
        cat = 'Bajo peso';
      else if (imc < 25)
        cat = 'Normal';
      else if (imc < 30)
        cat = 'Sobrepeso';
      else
        cat = 'Obesidad';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('IMC: ${imc.toStringAsFixed(1)} ($cat)')),
      );
    }
  }

  void limpiarIMC() {
    estaturaCtrl.clear();
    pesoCtrl.clear();
  }

  // Par/Impar
  void jugarPI(int numUsuario, bool esPar) {
    final cpuNum = Random().nextInt(6);
    final suma = numUsuario + cpuNum;
    bool ganaUsuario = (suma % 2 == 0) == esPar;

    if (ganaUsuario)
      usuarioScore++;
    else
      cpuScore++;

    setState(() {
      eleccionUsuario = numUsuario;
      resultadoPI =
          'Tú: $numUsuario, CPU: $cpuNum → ${ganaUsuario ? "Ganaste" : "Perdiste"}';
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(resultadoPI)));
  }

  void reiniciarPI() {
    setState(() {
      usuarioScore = 0;
      cpuScore = 0;
      resultadoPI = '';
      eleccionUsuario = null;
    });
  }

  // ==== Build ====
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kit Offline')),
      drawer: const AppDrawer(),
      body: _selectedModule == -1
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _menuCard('Notas Rápidas', Icons.note, 0),
                  _menuCard('IMC', Icons.calculate, 1),
                  _menuCard('Galería', Icons.image, 2),
                  _menuCard('Par o Impar', Icons.numbers, 3),
                ],
              ),
            )
          : IndexedStack(
              index: _selectedModule,
              children: [
                // ====== Notas ======
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: notaCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Nueva nota',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: agregarNota,
                            child: const Text('Agregar'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView(
                          children: notas
                              .map(
                                (n) => Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      n,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: borrarNotas,
                        child: const Text('Borrar Todo'),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: volverMenu,
                        child: const Text('Volver al Menú'),
                      ),
                    ],
                  ),
                ),
                // ====== IMC ======
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: _imcKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: estaturaCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Estatura (m)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return 'Campo obligatorio';
                            final val = double.tryParse(v);
                            if (val == null || val <= 0)
                              return 'Número inválido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: pesoCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Peso (kg)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return 'Campo obligatorio';
                            final val = double.tryParse(v);
                            if (val == null || val <= 0)
                              return 'Número inválido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: calcularIMC,
                              child: const Text('Calcular'),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: limpiarIMC,
                              child: const Text('Limpiar'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: volverMenu,
                          child: const Text('Volver al Menú'),
                        ),
                      ],
                    ),
                  ),
                ),
                // ====== Galería ======
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: imagenes
                        .map(
                          (img) => InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: Image.asset(img),
                                  title: const Text('Imagen'),
                                ),
                              );
                            },
                            child: Image.asset(img, fit: BoxFit.cover),
                          ),
                        )
                        .toList(),
                  ),
                ),
                // ====== Par o Impar ======
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        'Marcador: Usuario $usuarioScore - CPU $cpuScore',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        children: List.generate(
                          6,
                          (i) => ElevatedButton(
                            onPressed: () => jugarPI(i, true),
                            child: Text('$i'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  jugarPI(eleccionUsuario ?? 0, true),
                              child: const Text('Par'),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  jugarPI(eleccionUsuario ?? 0, false),
                              child: const Text('Impar'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: reiniciarPI,
                        child: const Text('Reiniciar Marcador'),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: volverMenu,
                        child: const Text('Volver al Menú'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _menuCard(String titulo, IconData icono, int index) {
    return Card(
      color: Colors.orange[200],
      elevation: 4,
      child: InkWell(
        onTap: () => abrirModulo(index),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icono, size: 48, color: Colors.deepOrange),
              const SizedBox(height: 12),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
