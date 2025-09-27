import 'package:flutter/material.dart';
import 'drawer_widget.dart';

class Practica4Formulario extends StatefulWidget {
  const Practica4Formulario({super.key});

  @override
  State<Practica4Formulario> createState() => _Practica4FormularioState();
}

class _Practica4FormularioState extends State<Practica4Formulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  bool mostrarPass = false;

  void limpiar() {
    nombreCtrl.clear();
    emailCtrl.clear();
    passCtrl.clear();
    setState(() {});
  }

  void enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrado: ${nombreCtrl.text} (${emailCtrl.text})'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Práctica 4: Formulario')),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo obligatorio';
                  if (v.length < 3) return 'Mínimo 3 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo obligatorio';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v))
                    return 'Email inválido';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passCtrl,
                obscureText: !mostrarPass,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      mostrarPass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        mostrarPass = !mostrarPass;
                      });
                    },
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo obligatorio';
                  if (v.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: enviar,
                    child: const Text('Enviar'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: limpiar,
                    child: const Text('Limpiar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
