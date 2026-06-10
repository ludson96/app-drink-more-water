import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controllers/water_controller.dart';
import '../models/water_intake_model.dart';

class HomeView extends StatefulWidget {
  final WaterController controller;

  const HomeView({super.key, required this.controller});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Cria uma animação de pulso: cresce até 1.4x e depois volta para 1.0x com efeito de "bounce"
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.4,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.4,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 50,
      ),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
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
                Expanded(child: _buildHistoryList(intakes.toList())),
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
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress > 1 ? 1 : progress),
              duration: const Duration(milliseconds: 800),
              curve: Curves
                  .easeOutBack, // Adiciona um leve efeito elástico no final
              builder: (context, animatedProgress, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: animatedProgress,
                        strokeWidth: 12,
                        backgroundColor: Colors.blue.withValues(alpha: 0.2),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: const Icon(
                            Icons.water_drop,
                            color: Colors.blueAccent,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(animatedProgress * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
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
      onPressed: () {
        widget.controller.addWater(amount);
        // Aciona a animação de "pulso" na gota d'água a partir do 0 sempre que clicado
        _animationController.forward(from: 0.0);
      },
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
        final timeString =
            '${item.time.hour.toString().padLeft(2, '0')}:${item.time.minute.toString().padLeft(2, '0')}';
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
