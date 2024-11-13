import 'package:crud_demo/provider/postprovider.dart';
import 'package:crud_demo/screen/postlistscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Postprovider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // AppBar ka background color
          titleTextStyle: TextStyle(
            color: Colors.white, // Title text ka color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // AppBar ke icons ka color
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Postlistscreen(),
    );
  }
}
