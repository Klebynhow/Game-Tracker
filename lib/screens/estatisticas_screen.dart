import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/jogo.dart';

class EstatisticasScreen extends StatelessWidget {
  final List<Jogo> jogos;

  const EstatisticasScreen({super.key, required this.jogos});

  @override
  Widget build(BuildContext context) {
    if (jogos.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Estatísticas')),
        body: const Center(child: Text('Nenhum jogo cadastrado.')),
      );
    }

    final jogoMaisJogado = jogos.reduce((a, b) => a.horasJogadas > b.horasJogadas ? a : b);
    final jogoMelhorAvaliado = jogos.reduce((a, b) => a.avaliacao > b.avaliacao ? a : b);

    return Scaffold(
      appBar: AppBar(title: const Text('Estatísticas da Coleção')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.blue.shade50,
              child: ListTile(
                leading: const Icon(Icons.timer, color: Colors.blue, size: 36),
                title: const Text('Jogo com mais horas', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${jogoMaisJogado.nome} (${jogoMaisJogado.horasJogadas.toStringAsFixed(1)}h)'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.amber.shade50,
              child: ListTile(
                leading: const Icon(Icons.star, color: Colors.amber, size: 36),
                title: const Text('Jogo mais bem avaliado', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${jogoMelhorAvaliado.nome} (⭐ ${jogoMelhorAvaliado.avaliacao.toStringAsFixed(1)})'),
              ),
            ),
            const SizedBox(height: 24),

            const Text('Horas Jogadas por Jogo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < jogos.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                jogos[index].nome.split(' ').first,
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  barGroups: jogos.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final j = entry.value;
                    return BarChartGroupData(
                      x: idx,
                      barRods: [
                        BarChartRodData(
                          toY: j.horasJogadas,
                          color: Colors.indigo,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}