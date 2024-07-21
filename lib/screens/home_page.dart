import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/incidence_provider.dart';
import 'incidence_form.dart';
import 'incidence_list.dart';
import 'about_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Incidencias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<IncidenceProvider>(context, listen: false).deleteAllIncidences();
            },
          ),
        ],
      ),
      body: const IncidenceList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IncidenceForm()),
          );
        },
        tooltip: 'Añadir Incidencia',
        child: const Icon(Icons.add),
      ),
    );
  }
}