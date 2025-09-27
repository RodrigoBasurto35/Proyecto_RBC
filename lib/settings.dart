import 'package:flutter/material.dart';
import 'drawer_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          SwitchListTile(
            title: const Text('Tema Oscuro'),
            subtitle: const Text('Activa o desactiva el tema oscuro'),
            value: isDarkMode,
            onChanged: (val) {
              setState(() {
                isDarkMode = val;
              });
              final theme = val ? ThemeMode.dark : ThemeMode.light;
              // Cambiar tema global si se implementa ThemeMode
              // Aquí solo para demo, no afecta MaterialApp directamente
            },
            secondary: const Icon(Icons.brightness_6),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            subtitle: const Text('Versión 1.0.0\nAutor: Amairani Abigail Lara'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'AppHub Portafolio',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025',
                children: const [Text('Proyecto de demostración Flutter.')],
              );
            },
          ),
        ],
      ),
    );
  }
}
