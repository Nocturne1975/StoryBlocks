import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/Theme/storyblocks_tokens.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.sbTokens;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.trending_up, color: tokens.blockScene, size: 24),
            const SizedBox(width: 8),
            const Text(
              'Statistiques',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const _SummaryCard(
              title: 'Série actuelle',
              value: '7 jours',
              subtitle: 'Record: 14 jours',
              icon: Icons.track_changes,
              color: Color(0xFFF97316),
            ),
            const SizedBox(height: 12),
            const _SummaryCard(
              title: 'Moyenne/jour',
              value: '17 blocs',
              subtitle: '+23% ce mois',
              icon: Icons.show_chart,
              color: Color(0xFFF59E0B),
            ),
            const _SummaryCard(
              title: 'Ce mois',
              value: '280 blocs',
              subtitle: 'Objectif: 100',
              icon: Icons.calendar_today,
              color: Color(0xFFD4A340),
            ),
            const SizedBox(height: 32),

            const _SectionTitle(
              title: 'Activité - 30 derniers jours',
              icon: Icons.calendar_month_outlined,
            ),
            const SizedBox(height: 16),
            const _ActivityHeatmap(),
            const SizedBox(height: 32),

            const _SectionTitle(
              title: 'Cette semaine',
              icon: Icons.stacked_line_chart,
            ),
            const SizedBox(height: 16),
            const _WeeklyChart(),
            const SizedBox(height: 32),

            const _SectionTitle(
              title: 'Évolution mensuelle',
              icon: Icons.bar_chart,
            ),
            const SizedBox(height: 16),
            const _MonthlyChart(),
            const SizedBox(height: 32),

            const _SectionTitle(
              title: 'Types de blocs',
              icon: Icons.pie_chart_outline,
            ),
            const SizedBox(height: 16),
            _BlockTypesList(tokens: tokens),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange[800], size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xB3FFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityHeatmap extends StatelessWidget {
  const _ActivityHeatmap();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(30, (index) {
              final opacities = [0.1, 0.3, 0.5, 0.8, 1.0];
              final opacity = opacities[index % 5];
              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: opacity),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Moins',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Row(
                children: [0.1, 0.3, 0.5, 0.8, 1.0]
                    .map(
                      (o) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: o),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const Text(
                'Plus',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeeklyChart extends StatelessWidget {
  const _WeeklyChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomPaint(painter: _LineChartPainter(), child: Container()),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.16, size.height * 0.4),
      Offset(size.width * 0.33, size.height * 0.8),
      Offset(size.width * 0.5, size.height * 0.5),
      Offset(size.width * 0.66, size.height * 0.2),
      Offset(size.width * 0.83, size.height * 0.1),
      Offset(size.width, size.height * 0.3),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, paint);

    final dotPaint = Paint()..color = Colors.orange;
    for (var point in points) {
      canvas.drawCircle(point, 5, dotPaint);
    }

    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.1)
      ..strokeWidth = 1;
    for (var i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MonthlyChart extends StatelessWidget {
  const _MonthlyChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Bar(height: 0.6, label: 'Jan'),
          _Bar(height: 0.75, label: 'Fév'),
          _Bar(height: 1.0, label: 'Mar'),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double height;
  final String label;
  const _Bar({required this.height, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: FractionallySizedBox(
            heightFactor: height,
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD4A340),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}

class _BlockTypesList extends StatelessWidget {
  final StoryBlocksTokens tokens;
  const _BlockTypesList({required this.tokens});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _ProgressRow(
            label: 'Scène',
            value: '342',
            progress: 0.8,
            color: tokens.blockScene,
          ),
          _ProgressRow(
            label: 'Personnage',
            value: '89',
            progress: 0.3,
            color: tokens.blockCharacter,
          ),
          _ProgressRow(
            label: 'Lieu',
            value: '67',
            progress: 0.25,
            color: tokens.blockPlace,
          ),
          _ProgressRow(
            label: 'Idée',
            value: '156',
            progress: 0.5,
            color: tokens.blockIdea,
          ),
          _ProgressRow(
            label: 'Thème',
            value: '45',
            progress: 0.15,
            color: tokens.blockTheme,
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color color;

  const _ProgressRow({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF3F4F6),
              color: color,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
