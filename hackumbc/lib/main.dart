import 'package:flutter/material.dart';
import 'package:hackumbc/screens/landing.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Yum Yum',
    theme: ThemeData(
      primarySwatch: Colors.pink,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const SpinKitCubeGrid(
            color: Colors.black,
            size: 50.0,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const Landing();
        }

        return const SpinKitCubeGrid(
          color: Colors.pinkAccent,
          size: 50.0,
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yum Yum',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Landing(),
    );
  }
}
