
// -------------------------------------------------------------------------- //

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// -- MAIN ------------------------------------------------------------------ //

void main() {
    runApp(const MainApp());
}

class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
        return const MaterialApp(
            title: "POST PAGE",
            home: LoginPage(),
        );
    }
}

// -- LOGIN PAGE ------------------------------------------------------------ //

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController _nameController = TextEditingController();

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
                            Image.asset('assets/ashenOne.png', width: 240),
                            const SizedBox(height: 60),

                            TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Escribe tu nombre',
                                    labelText: 'And who are you? The proud Lord said...',
                                ),
                            ),
                            const SizedBox(height: 20),

                            ElevatedButton(
                                onPressed: () {
                                    String nombre = _nameController.text.trim();

                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) => PostPage(
                                                message: "¡Hola, $nombre!",
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

// -- POST PAGE ------------------------------------------------------------- //

class PostPage extends StatefulWidget {
    final String message;
    const PostPage({super.key, required this.message});

    @override
    State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
    String responseText = "";

    Future<void> createPost() async {
        final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

        final response = await http.post(url, headers: {
            "Content-Type": "application/json;  charset=UTF-8",
        }, body: jsonEncode({
            "title": "Starscourge POST",
            "body": "Champions, welcome!",
            "userId": 1,
        }));

        if (response.statusCode == 201) {
            setState(() {
                responseText = response.body;
            });
        } else {
            setState(() {
                responseText = "ERROR: ${response.statusCode}";
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text("POST Page"),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
            ),

            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                        Text(widget.message,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: createPost,
                            child: const Text("Enviar petición POST"),
                        ),

                        const SizedBox(height: 20),
                        Text(responseText),
                    ]
                )
            )
        );
    }
}

// -- GET PAGE -------------------------------------------------------------- //

class GetPage extends StatefulWidget {
    final String message;
    const GetPage({super.key, required this.message});

    @override
    State<GetPage> createState() => _GetPageState();
}

class _GetPageState extends State<GetPage> {
    double? exchangeRate;
    bool loading = true;

    @override
    void initState() {
        super.initState();
        obtenerTipoCambio();
    }

    Future<void> obtenerTipoCambio() async {
        final url = Uri.parse('https://open.er-api.com/v6/latest/USD');
        final response = await http.get(url); // Petición.

        if (response.statusCode == 200) {
            final data = jsonDecode(response.body);

            setState(() {
                exchangeRate = data['rates']['MXN'];
                loading = false;
            });
        } else {
            setState(() {
                loading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            extendBodyBehindAppBar: true,

            appBar: AppBar(
                title: const Text('Development'),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
            ),

            body: Center(child: loading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(widget.message,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        Text(exchangeRate != null
                            ? '1 USD es equivalente a $exchangeRate MXN'
                            : 'Ha ocurrido un error en la consulta.',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                        ),
                    ],
                ),
            ),
        );
    }
}

// -------------------------------------------------------------------------- //