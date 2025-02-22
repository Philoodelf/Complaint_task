import 'package:flutter/material.dart';
import 'complaint/screens/description.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      title: 'Flutter Demo',
      theme: ThemeData(
         appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 232, 232, 232),
          foregroundColor: Colors.white //here you can give the text color
          ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Description(title: '',),
    );
  }
}

