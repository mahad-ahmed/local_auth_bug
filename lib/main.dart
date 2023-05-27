import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Bug',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalAuthentication _auth = LocalAuthentication();

  String _message = "Starting Message";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Authentication Bug'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: ElevatedButton(
                child: const Text("Authenticate"),
                onPressed: () async {
                  print("\n============ CALLING authenticate() ============\n");
                  // Press the lock button while authentication popup is open to replicate the issue.
                  bool isAuthenticated = await _auth.authenticate(
                    localizedReason: "Please authenticate to login",
                    options: const AuthenticationOptions(biometricOnly: true),
                  );
                  // isAuthenticated is true
                  print("\n============ authenticate() returned with: $isAuthenticated ============\n");
                  if(isAuthenticated == true) {
                    setState(() {
                      _message = "We are now authenticated";
                    });
                  }
                },
              ),
            ),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
