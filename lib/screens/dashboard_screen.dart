import 'dart:math';
import 'package:flutter/material.dart';
import '../models/jogo.dart';
import 'lista_jogos_screen.dart';
import 'estatisticas_screen.dart';

class DashboardScreen extends StatefulWidget {
  final List<Jogo> jogos;

  const DashboardScreen({super.key, required this.jogos});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Jogo? _jogoSorteado;

  void _sortearJogo() {
    if (widget.jogos.isNotEmpty) {
      final random = Random();
      final index = random.nextInt(widget.jogos.length);
      setState(() {
        _jogoSorteado = widget.jogos[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalJogos = widget.jogos.length;
    final totalHoras = widget.jogos.fold<double>(0, (sum, j) => sum + j.horasJogadas);
    final mediaNotas = totalJogos > 0
        ? widget.jogos.fold<double>(0, (sum, j) => sum + j.avaliacao) / totalJogos
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Tracker - Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: _buildMetricCard('Total Jogos', '$totalJogos', Colors.indigo)),
                const SizedBox(width: 8),
                Expanded(child: _buildMetricCard('Total Horas', '${totalHoras.toStringAsFixed(1)}h', Colors.teal)),
                const SizedBox(width: 8),
                Expanded(child: _buildMetricCard('Média Notas', mediaNotas.toStringAsFixed(1), Colors.amber.shade800)),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              icon: const Icon(IconData(0xe3b7, fontFamily: 'MaterialIcons')), // sports_esports
              label: const Text('Ver Lista de Jogos', style: TextStyle(fontSize: 16)),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ListaJogosScreen(jogos: widget.jogos)),
                );
                setState(() {});
              },
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              icon: const Icon(IconData(0xe0b2, fontFamily: 'MaterialIcons')), // bar_chart
              label: const Text('Ver Estatísticas e Gráficos', style: TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EstatisticasScreen(jogos: widget.jogos)),
                );
              },
            ),
            const SizedBox(height: 28),

            // Seção "O que jogar?" (Sorteio Aleatório)
            Card(
              elevation: 4,
              color: Colors.deepPurple.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      '🎲 O que jogar hoje?',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 8),
                    const Text('Sorteie um jogo da sua coleção para sua próxima sessão!'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                      onPressed: _sortearJogo,
                      child: const Text('Sortear Jogo'),
                    ),
                    if (_jogoSorteado != null) ...[
                      const Divider(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          _jogoSorteado!.imagemUrl,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.gamepad, size: 80),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _jogoSorteado!.nome,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('${_jogoSorteado!.genero} • ${_jogoSorteado!.plataforma}',
                          style: TextStyle(color: Colors.grey.shade700)),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Card(
      elevation: 3,
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}