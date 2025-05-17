import 'package:flutter/material.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';

class WaveCardWidget extends StatelessWidget {
  final Widget child;
  final double width;
  final double? height;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets? padding;
  final bool isSelected;

  const WaveCardWidget({
    super.key,
    required this.child,
    required this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.borderRadius = 20,
    this.padding,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaveShapePainter(
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        isSelected: isSelected,
      ),
      child: Container(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

class WaveShapePainter extends CustomPainter {
  final Color backgroundColor;
  final double borderRadius;
  final bool isSelected;

  WaveShapePainter({
    required this.backgroundColor,
    required this.borderRadius,
    required this.isSelected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Gölge için paint oluştur
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Ana şekil için paint
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    if (isSelected) {
      paint.color = AppColor.noxious.getColor().withOpacity(0.1);
    }

    final path = Path();
    
    // Sol üst köşe radius
    path.moveTo(0, borderRadius * 2.5);
    path.quadraticBezierTo(0, 0, borderRadius * 2.5, 0);
    
    // Üst kenar boyunca düz git
    path.lineTo(size.width * 0.3, 0);
    
    // Yumuşak dalga eğrisi
    path.quadraticBezierTo(
      size.width * 0.35, 0, // Kontrol noktası (0.4'ten 0.35'e düşürüldü)
      size.width * 0.4, borderRadius * 0.5, // Tepe noktası (0.75'ten 0.5'e düşürüldü)
    );
    path.quadraticBezierTo(
      size.width * 0.45, borderRadius, // Kontrol noktası (değerler yumuşatıldı)
      size.width * 0.5, borderRadius, // Tepe noktası (1.5'ten 1'e düşürüldü)
    );
    
    // Sağ dalga
    path.quadraticBezierTo(
      size.width * 0.55, borderRadius, // Kontrol noktası (değerler yumuşatıldı)
      size.width * 0.6, borderRadius * 0.5, // Bitiş noktası (0.75'ten 0.5'e düşürüldü)
    );
    path.quadraticBezierTo(
      size.width * 0.65, 0, // Kontrol noktası (0.6'dan 0.65'e çıkarıldı)
      size.width * 0.7, 0, // Bitiş noktası
    );
    
    // Sağ üst köşe radius
    path.lineTo(size.width - borderRadius * 2.5, 0);
    path.quadraticBezierTo(size.width, 0, size.width, borderRadius * 2.5);
    
    // Sağ kenar
    path.lineTo(size.width, size.height);
    
    // Alt kenar
    path.lineTo(0, size.height);
    
    // Sol kenar
    path.lineTo(0, borderRadius);
    
    path.close();

    // Önce gölgeyi çiz
    canvas.drawPath(path, shadowPaint);
    // Sonra ana şekli çiz
    canvas.drawPath(path, paint);

    // Border çizimi (seçili durum için)
    if (isSelected) {
      final borderPaint = Paint()
        ..color = AppColor.noxious.getColor()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 