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
      title: 'Mi primer APP con navegación: Ed Rubio',
      theme: ThemeData(primarySwatch: Colors.red, useMaterial3: true),

      home: const LoginScreen(),
    );
  }
}

// Inicio de sesión:
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();

  final String radahnFestival =
      "Champions, welcome! The stars have aligned! The festival is nigh! General Radahn, mightiest demigod of the Shattering, awaits you! Champions, prepare for battle! Defeat the General, claim glory, and grab that Great Rune! A celebration of war! The Radahn Festival!";

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PANTALLA DE INICIO',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/ashenOne.png', width: 240),
              const SizedBox(height: 20),

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe tu nombre',
                  labelText: 'Nombre del campeón...',
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  String nombre = _nameController.text.trim();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        message: "¡Hola, $nombre! \n\n$radahnFestival",
                      ),
                    ),
                  );
                },
                child: const Text('CONTINUAR'),
              ),
            ],
          ),
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
            child: Image.asset('assets/ashenOne.png', fit: BoxFit.cover),
          ),

          Positioned.fill(child: Container(color: Colors.black54)),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        fontSize: 22,
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
                    label: const Text('Regresar. :('),
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
