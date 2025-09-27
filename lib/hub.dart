import 'package:flutter/material.dart';
import 'practicas_index.dart';
import 'kit_offline.dart';
import 'settings.dart';
import 'drawer_widget.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modules = [
      {'title': 'Prácticas', 'widget': PracticasIndex()},
      {'title': 'Kit Offline', 'widget': const KitOffline()},
      {'title': 'Ajustes', 'widget': const SettingsScreen()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('AppHub Portafolio')),
      drawer: const AppDrawer(),
      body: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: modules
            .map(
              (m) => Card(
                color: Colors.orange[200],
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => m['widget'] as Widget),
                  ),
                  child: Center(
                    child: Text(
                      m['title'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[900],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
