import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/marijose.jpg'), // Asegúrate de tener esta imagen en la carpeta assets
            ),
            const SizedBox(height: 16.0),
            const Text('Nombre: Maria Jose'),
            const Text('Apellido: Suarez Molina'),
            const Text('Matrícula: 2022-1104'),
            const SizedBox(height: 16.0),
            const Text(
              'Reflexión: Tu seguridad siempre sera nuestra maxima prioridad.',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}