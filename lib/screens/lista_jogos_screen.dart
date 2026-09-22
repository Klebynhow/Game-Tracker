import 'package:flutter/material.dart';
import '../models/jogo.dart';
import 'detalhes_jogo_screen.dart';

class ListaJogosScreen extends StatefulWidget {
  final List<Jogo> jogos;

  const ListaJogosScreen({super.key, required this.jogos});

  @override
  State<ListaJogosScreen> createState() => _ListaJogosScreenState();
}

class _ListaJogosScreenState extends State<ListaJogosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coleção de Jogos')),
      body: ListView.builder(
        itemCount: widget.jogos.length,
        itemBuilder: (context, index) {
          final jogo = widget.jogos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  jogo.imagemUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.gamepad, size: 50),
                ),
              ),
              title: Text(jogo.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${jogo.genero} • ${jogo.plataforma}'),
                  Text('⭐ ${jogo.avaliacao.toStringAsFixed(1)} | ⏱️ ${jogo.horasJogadas.toStringAsFixed(1)}h'),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetalhesJogoScreen(jogo: jogo)),
                );
                setState(() {});
              }),
          );
        },
      ),
    );
  }
}