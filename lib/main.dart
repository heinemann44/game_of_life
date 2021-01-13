import 'package:flutter/material.dart';
import 'package:game_of_life_flutter/features/home/presentation/home.dart';

/*
I want to have an initial game loaded upon launch - ok
I can play the game - ok
I can pause the game - ok
I can reset the game to its initial state - ok
I can see the game state frame by frame - ok
I can increase/decrease the speed of the game - ok
I can see the list of available games
I can select one of those game (and play with it)
I can to create a game (and play with it) - ok
 */


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
