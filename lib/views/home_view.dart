import 'package:flutter/material.dart';
import '../controllers/water_controller.dart';
import '../models/water_intake_model.dart';

class HomeView extends StatefulWidget {
  final WaterController controller;

  const HomeView({super.key, required this.controller});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final totalConsumed = widget.controller.totalConsumed;
        final target = widget.controller.goal.targetInMl;
        final progress = widget.controller.progress;
        final intakes = widget.controller.intakes;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Beber Água'),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProgressCard(totalConsumed, target, progress),
                const SizedBox(height: 24),
                const Text(
                  'Adicionar Água',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildQuickAddButtons(),
                const SizedBox(height: 24),
                const Text(
                  'Histórico de Hoje',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildHistoryList(intakes),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressCard(int total, int target, double progress) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: progress > 1 ? 1 : progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.blue.withValues(alpha: 0.2),
                    color: Colors.blueAccent,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.water_drop, color: Colors.blueAccent, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '$total ml / $target ml',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAddButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildAddButton(100),
        _buildAddButton(200),
        _buildAddButton(500),
      ],
    );
  }

  Widget _buildAddButton(int amount) {
    return ElevatedButton.icon(
      onPressed: () => widget.controller.addWater(amount),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      icon: const Icon(Icons.add, size: 18),
      label: Text('$amount ml'),
    );
  }

  Widget _buildHistoryList(List<WaterIntake> intakes) {
    if (intakes.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum registro hoje. Beba água!',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      itemCount: intakes.length,
      itemBuilder: (context, index) {
        // Reversed so latest is at the top
        final item = intakes[intakes.length - 1 - index];
        final timeString = '${item.time.hour.toString().padLeft(2, '0')}:${item.time.minute.toString().padLeft(2, '0')}';
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.local_drink, color: Colors.blueAccent),
            title: Text('${item.amountInMl} ml'),
            subtitle: Text(timeString),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => widget.controller.removeWater(item.id),
            ),
          ),
        );
      },
    );
  }
}
