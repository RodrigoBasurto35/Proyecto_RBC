import 'package:flutter/material.dart';
import 'hub.dart';
import 'practicas_index.dart';
import 'kit_offline.dart';
import 'settings.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
              ),
            ),
            child: const Center(
              child: Text(
                'Menú Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HubScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Índice de Prácticas'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PracticasIndex()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Kit Offline'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const KitOffline()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Ajustes / Acerca de'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
