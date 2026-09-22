import 'package:flutter/material.dart';
import '../models/jogo.dart';

class DetalhesJogoScreen extends StatefulWidget {
  final Jogo jogo;

  const DetalhesJogoScreen({super.key, required this.jogo});

  @override
  State<DetalhesJogoScreen> createState() => _DetalhesJogoScreenState();
}

class _DetalhesJogoScreenState extends State<DetalhesJogoScreen> {
  void _alterarHoras(double delta) {
    setState(() {
      final novoValor = widget.jogo.horasJogadas + delta;
      if (novoValor >= 0) {
        widget.jogo.horasJogadas = novoValor;
      }
    });
  }

  void _alterarAvaliacao(double delta) {
    setState(() {
      final novoValor = widget.jogo.avaliacao + delta;
      if (novoValor >= 0 && novoValor <= 10) {
        widget.jogo.avaliacao = double.parse(novoValor.toStringAsFixed(1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final j = widget.jogo;

    return Scaffold(
      appBar: AppBar(title: Text(j.nome)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              j.imagemUrl,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.gamepad, size: 100),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(j.nome, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${j.genero} • ${j.plataforma}', style: TextStyle(color: Colors.grey.shade700, fontSize: 16)),
                  const SizedBox(height: 12),
                  const Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(j.descricao),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Horas Jogadas: ${j.horasJogadas.toStringAsFixed(1)}h',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () => _alterarHoras(-1.0),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                            onPressed: () => _alterarHoras(1.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Avaliação: ⭐ ${j.avaliacao.toStringAsFixed(1)} / 10',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () => _alterarAvaliacao(-0.5),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                            onPressed: () => _alterarAvaliacao(0.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}