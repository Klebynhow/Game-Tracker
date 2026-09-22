import 'package:flutter/material.dart';
import 'data/dados_iniciais.dart';
import 'models/jogo.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const GameTrackerApp());
}

class GameTrackerApp extends StatefulWidget {
  const GameTrackerApp({super.key});

  @override
  State<GameTrackerApp> createState() => _GameTrackerAppState();
}

class _GameTrackerAppState extends State<GameTrackerApp> {
  late final List<Jogo> _jogos;

  @override
  void initState() {
    super.initState();
    _jogos = getJogosIniciais();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: DashboardScreen(jogos: _jogos),
    );
  }
}