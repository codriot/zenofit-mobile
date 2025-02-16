import 'package:flutter/material.dart';

class IsometricBarWidget extends StatefulWidget {
  final double height;
  final double width;
  final Color topColor;
  final Color frontColor;
  final double fillPercentage;
  final Duration duration;

  const IsometricBarWidget({
    super.key,
    this.height = 200,
    this.width = 40,
    this.topColor = Colors.grey,
    this.frontColor = Colors.blue,
    this.fillPercentage = 0.6,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<IsometricBarWidget> createState() => _IsometricBarWidgetState();
}

class _IsometricBarWidgetState extends State<IsometricBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.fillPercentage,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(IsometricBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fillPercentage != widget.fillPercentage) {
      _animation = Tween<double>(
        begin: oldWidget.fillPercentage,
        end: widget.fillPercentage,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: CustomPaint(
            painter: IsometricBarPainter(
              topColor: widget.topColor,
              frontColor: widget.frontColor,
              fillPercentage: _animation.value,
            ),
          ),
        );
      },
    );
  }
}

class IsometricBarPainter extends CustomPainter {
  final Color topColor;
  final Color frontColor;
  final double fillPercentage;

  IsometricBarPainter({
    required this.topColor,
    required this.frontColor,
    required this.fillPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Sabit değerler
    final sideOffset = 15.0;  // Yan genişlik (20'den 15'e düşürüldü)
    final topOffset = 12.0;   // Üst kısım yüksekliği
    final barWidth = 30.0;    // Toplam genişlik (40'tan 30'a düşürüldü)
    final barHeight = size.height - topOffset; // Toplam yükseklik (üst kısım hariç)
    final filledHeight = barHeight * fillPercentage;

    // Boş kısım (gri)
    // Sol yüz
    final emptyFrontPath = Path()
      ..moveTo(0, 0)
      ..lineTo(sideOffset, topOffset)
      ..lineTo(sideOffset, size.height - filledHeight)
      ..lineTo(0, size.height - filledHeight - topOffset)
      ..close();

    paint.color = topColor.withOpacity(0.7);
    canvas.drawPath(emptyFrontPath, paint);

    // Sağ yüz
    final emptyReversePath = Path()
      ..moveTo(barWidth, 0)
      ..lineTo(sideOffset, topOffset)
      ..lineTo(sideOffset, size.height - filledHeight)
      ..lineTo(barWidth, size.height - filledHeight - topOffset)
      ..close();

    paint.color = topColor.withOpacity(0.5);
    canvas.drawPath(emptyReversePath, paint);

    Path? frontPath;
    Path? reverseFrontPath;

    // Dolu kısım için pathler
    if (fillPercentage > 0) {
      frontPath = Path()
        ..moveTo(0, size.height - filledHeight - topOffset)
        ..lineTo(sideOffset, size.height - filledHeight)
        ..lineTo(sideOffset, size.height)
        ..lineTo(0, size.height - topOffset)
        ..close();

      reverseFrontPath = Path()
        ..moveTo(barWidth, size.height - filledHeight - topOffset)
        ..lineTo(sideOffset, size.height - filledHeight)
        ..lineTo(sideOffset, size.height)
        ..lineTo(barWidth, size.height - topOffset)
        ..close();

      // Sol yüz (koyu)
      paint.color = frontColor;
      canvas.drawPath(frontPath, paint);

      // Sağ yüz gradient (açık)
      final frontGradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          frontColor.withOpacity(0.7),
          frontColor.withOpacity(0.5),
        ],
      );

      paint.shader = frontGradient.createShader(
        Rect.fromLTWH(0, size.height - filledHeight, barWidth, filledHeight),
      );
      canvas.drawPath(reverseFrontPath, paint);

      // Dolu kısım için üst yüz (sadece kısmi dolulukta)
      if (fillPercentage < 1.0) {
        final filledTopPath = Path()
          ..moveTo(0, size.height - filledHeight - topOffset)
          ..lineTo(sideOffset, size.height - filledHeight)
          ..lineTo(barWidth, size.height - filledHeight - topOffset)
          ..lineTo(sideOffset, size.height - filledHeight - topOffset * 2)
          ..close();

        paint.shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            frontColor.withOpacity(0.9),
            frontColor.withOpacity(0.4),
          ],
        ).createShader(
          Rect.fromLTWH(0, size.height - filledHeight - topOffset * 2, barWidth, topOffset * 2),
        );
        canvas.drawPath(filledTopPath, paint);
      }
    }

    // En üst yüz (her zaman en üstte)
    final topPath = Path()
      ..moveTo(0, 0)
      ..lineTo(sideOffset, -topOffset)
      ..lineTo(barWidth, 0)
      ..lineTo(sideOffset, topOffset)
      ..close();
  
    // Üst yüz gradient
    final topGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        topColor.withOpacity(0.9),
        topColor.withOpacity(0.7),
      ],
    );

    paint.shader = topGradient.createShader(
      Rect.fromLTWH(0, -topOffset, barWidth, topOffset * 2),
    );
    canvas.drawPath(topPath, paint);

    // Kenar çizgileri
    final strokePaint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    canvas.drawPath(emptyFrontPath, strokePaint);
    canvas.drawPath(emptyReversePath, strokePaint);
    canvas.drawPath(topPath, strokePaint);
    if (fillPercentage > 0 && frontPath != null && reverseFrontPath != null) {
      canvas.drawPath(frontPath, strokePaint);
      canvas.drawPath(reverseFrontPath, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 