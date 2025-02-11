import 'package:flutter/material.dart';
import 'package:work/Splash.dart';



class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Spalsh(),
    );
  }
}
void main(){
  runApp(myapp());
}