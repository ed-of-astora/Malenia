// Importaciones:
import 'package:flutter/material.dart';

// Función principal:
void main() {
  runApp(const NavegacionFlutterApp());
}

// Widget raíz de la aplicación:
class NavegacionFlutterApp extends StatelessWidget {
  const NavegacionFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Erdtree: Navegación Flutter',
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),

      home: const HomeScreen(),
    );
  }
}

// Pantalla de inicio:
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Mensajito para enviar a la siguiente pantalla:
  final String radahnFestival =
      "Champions, welcome! The stars have aligned! The festival is nigh! General Radahn, mightiest demigod of the Shattering, awaits you! Champions, prepare for battle! Defeat the General, claim glory, and grab that Great Rune! A celebration of war! The Radahn Festival!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LIMGRAVE'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white70,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Limgrave',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Ir al siguiente sitio de gracia.'),
            const SizedBox(height: 20),

            // Navvegación:
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // El mensajito del Radahn Festival. :)
                    builder: (context) => DetailScreen(message: radahnFestival),
                  ),
                );
              },
              child: const Text('Acceder a Caelid.'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla de detalles:
class DetailScreen extends StatelessWidget {
  final String message;

  const DetailScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text('RADAHN FESTIVAL'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://www.gamepur.com/wp-content/uploads/2022/03/03112104/Elden-Ring-Radahn-Festival.jpg?w=1200',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(child: Container(color: Colors.black54)),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'JERREN:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 40),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                    ),
                    label: const Text('Retirada. :('),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
