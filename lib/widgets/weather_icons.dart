import 'package:flutter/material.dart';

class WeatherIcon extends CustomPainter {
  const WeatherIcon({required this.cloudiness, required this.radius});
  final double cloudiness;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(radius * 2, radius);

    drawSun(canvas, center);
    drawCloud(canvas, center, Colors.grey, true);
    drawCloud(canvas, center, Colors.grey[800]!, false);
    drawRain(canvas, center);
  }

  void drawSun(Canvas canvas, Offset center) {
    final painterSun = Paint()
      ..color = Colors.amberAccent.withOpacity(_getSunOpacity(cloudiness))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, painterSun);
  }

  void drawCloud(Canvas canvas, Offset center, Color color, bool firstCloud) {
    final painterCloud = Paint()
      ..color = color.withOpacity(_getCloudOpacity(cloudiness, firstCloud))
      ..style = PaintingStyle.fill
    ;

    final curvePath = Path()
      ..moveTo(center.dx - radius * 2, center.dy + radius * 2 / 3) //A1
      ..quadraticBezierTo(center.dx - radius * 2, center.dy + radius * 7 / 9,
          center.dx - radius * 17 / 9, center.dy + radius)  //A2
      ..quadraticBezierTo(center.dx - radius * 5 / 3, center.dy + radius * 4 / 3,
          center.dx - radius * 1 / 3, center.dy + radius * 4 / 3)  //A3
      ..quadraticBezierTo(center.dx + radius, center.dy + radius * 4 / 3,
          center.dx + radius * 11 / 9, center.dy + radius)  //A4
      ..quadraticBezierTo(center.dx + radius * 4 / 3, center.dy + radius * 7 / 9,
          center.dx + radius * 4 / 3, center.dy + radius * 2 / 3)  //A5
      ..quadraticBezierTo(center.dx + radius * 4 / 3, center.dy + radius * 5 / 9,
          center.dx + radius * 11 / 9, center.dy + radius * 4 / 9)  //A6
      ..quadraticBezierTo(center.dx + radius * 8 / 9, center.dy + radius * 1 / 3,
          center.dx + radius * 2 / 3, center.dy + radius * 1 / 3)  //A7
      ..quadraticBezierTo(center.dx + radius * 1 / 3, center.dy,
          center.dx, center.dy)  //A8
      ..quadraticBezierTo(center.dx - radius * 1/ 3, center.dy,
          center.dx - radius * 10 / 9, center.dy + radius * 1 / 3)  //A9
      ..quadraticBezierTo(center.dx - radius * 16 / 9, center.dy + radius * 1 / 3,
          center.dx - radius * 17 / 9, center.dy + radius * 4 / 9)  //A10
      ..quadraticBezierTo(center.dx - radius * 2, center.dy + radius * 5 / 9,
          center.dx - radius * 2, center.dy + radius * 2 / 3)  //A11
      ..close();

    canvas.drawPath(curvePath, painterCloud);
  }

  void drawRain(Canvas canvas, Offset center) {
    final painterRain = Paint()
      ..color = Colors.blue.withOpacity(_getRainOpacity(cloudiness))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var pathRain = Path()
      ..moveTo(center.dx - radius * 5 / 3, center.dy + radius * 6 / 3)
      ..lineTo(center.dx - radius * 4 / 3, center.dy + radius * 5 / 3)
      ..close();

    canvas.drawPath(pathRain, painterRain);

    pathRain = Path()
      ..moveTo(center.dx - radius * 2 / 3, center.dy + radius * 6 / 3)
      ..lineTo(center.dx - radius * 1 / 3, center.dy + radius * 5 / 3)
      ..close();

    canvas.drawPath(pathRain, painterRain);

    pathRain = Path()
      ..moveTo(center.dx + radius * 1 / 3, center.dy + radius * 6 / 3)
      ..lineTo(center.dx + radius * 2 / 3, center.dy + radius * 5 / 3)
      ..close();

    canvas.drawPath(pathRain, painterRain);
  }

  double _getSunOpacity(double value) {
    if (value > 0.8) {
      return 0;
    } else if (value <= 0.5) {
      return 1;
    }
    return -10 / 3 * value + 8 / 3;
  }

  double _getCloudOpacity(double value, bool firstCloud) {
    if (firstCloud) {
      if (value < 0.3) {
        return 0;
      } else if (value > 0.5) {
        return 1;
      }
      return 5 * value - 1.5;
    } else {
      if (value < 0.5) {
        return 0;
      }
    }
    return 2 * value - 1;
  }

  double _getRainOpacity(double value) {
    if (value < 0.7) {
      return 0;
    }
    return 10/3 * value - 7/3;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}