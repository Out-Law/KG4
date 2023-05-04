import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class Rectangle {
  double x, y, size;
  Rectangle({required this.x, required this.y, required this.size});
}

class Shape {
  double x, y, size;
  String type;
  Shape({required this.x, required this.y, required this.size, required this.type});
}


class Point {
  final double x, y;
  Point(this.x, this.y);
}

enum OutCode { INSIDE, LEFT, RIGHT, BOTTOM, TOP }

OutCode computeOutCode(double x, double y, Point minClip, Point maxClip) {
  if (x < minClip.x) {
    return OutCode.LEFT;
  } else if (x > maxClip.x) {
    return OutCode.RIGHT;
  } else if (y < minClip.y) {
    return OutCode.BOTTOM;
  } else if (y > maxClip.y) {
    return OutCode.TOP;
  } else {
    return OutCode.INSIDE;
  }
}

bool outCodesEqual(OutCode oc1, OutCode oc2) {
  return (oc1.index & oc2.index) != 0;
}

List<Point> cohenSutherlandClip(Point p1, Point p2, Point minClip, Point maxClip) {
  double x1 = p1.x, y1 = p1.y, x2 = p2.x, y2 = p2.y;
  OutCode outcode1 = computeOutCode(x1, y1, minClip, maxClip);
  OutCode outcode2 = computeOutCode(x2, y2, minClip, maxClip);
  bool accept = false;

  while (true) {
    if (outcode1 == OutCode.INSIDE && outcode2 == OutCode.INSIDE) {
      accept = true;
      break;
    } else if ((outcode1.index & outcode2.index) != 0) { // Изменено условие проверки на отсутствие пересечения
      break;
    } else {
      double x, y;
      OutCode outcodeOut = outcode1 != OutCode.INSIDE ? outcode1 : outcode2;

      if (outcodeOut == OutCode.TOP) {
        x = x1 + (x2 - x1) * (maxClip.y - y1) / (y2 - y1);
        y = maxClip.y;
      } else if (outcodeOut == OutCode.BOTTOM) {
        x = x1 + (x2 - x1) * (minClip.y - y1) / (y2 - y1);
        y = minClip.y;
      } else if (outcodeOut == OutCode.RIGHT) {
        y = y1 + (y2 - y1) * (maxClip.x - x1) / (x2 - x1);
        x = maxClip.x;
      } else {
        y = y1 + (y2 - y1) * (minClip.x - x1) / (x2 - x1);
        x = minClip.x;
      }

      if (outcodeOut == outcode1) {
        x1 = x;
        y1 = y;
        outcode1 = computeOutCode(x1, y1, minClip, maxClip);
      } else {
        x2 = x;
        y2 = y;
        outcode2 = computeOutCode(x2, y2, minClip, maxClip);
      }
    }
  }

  if (accept) {
    return [Point(x1, y1), Point(x2, y2)];
  } else {
    return [];
  }
}

enum ClippingMode { DASHED, SOLID }

Future<void> main() async {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Отсечение прямоугольников')),
        body: ClippingDemo(),
      ),
    );
  }
}


class ClippingDemo extends StatefulWidget {
  @override
  _ClippingDemoState createState() => _ClippingDemoState();
}

class _ClippingDemoState extends State<ClippingDemo> {
  final List<Rectangle> _rectangles = [
    Rectangle(x: 0, y: 0, size: 200),
    Rectangle(x: 50, y: 50, size: 200),
    Rectangle(x: 100, y: 100, size: 200),
  ];
  int _activeRectangleIndex = 0;
  ClippingMode _clippingMode = ClippingMode.DASHED;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: CustomPaint(
              painter: ClippingPainter(
                rectangles: _rectangles,
                //activeRectangleIndex: _activeRectangleIndex,
                //clippingMode: _clippingMode,
              ),
              child: Container(),
            ),
          ),
        ),
        Slider(
          value: _rectangles[_activeRectangleIndex].x,
          onChanged: (newValue) {
            setState(() {
              _rectangles[_activeRectangleIndex].x = newValue;
            });
          },
          min: -100,
          max: 400,
        ),
        Slider(
          value: _rectangles[_activeRectangleIndex].y,
          onChanged: (newValue) {
            setState(() {
              _rectangles[_activeRectangleIndex].y = newValue;
            });
          },
          min: -100,
          max: 400,
        ),
        Slider(
          value: _rectangles[_activeRectangleIndex].size,
          onChanged: (newValue) {
            setState(() {
              _rectangles[_activeRectangleIndex].size = newValue;
            });
          },
          min: 0,
          max: 400,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _rectangles.length,
            (index) => ElevatedButton(
              onPressed: () {
                setState(() {
                  _activeRectangleIndex = index;
                });
              },
              child: Text('Квадрат ${index + 1}'),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Пунктирные отсечения'),
            Switch(
              value: _clippingMode == ClippingMode.SOLID,
              onChanged: (newValue) {
                setState(() {
                  _clippingMode =
                      newValue ? ClippingMode.SOLID : ClippingMode.DASHED;
                });
              },
            ),
            Text('Сплошные отсечения'),
          ],
        ),
      ],
    );
  }
}

class ClippingPainter extends CustomPainter {
  final List<Rectangle> rectangles;

  ClippingPainter({
    required this.rectangles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < rectangles.length; i++) {
      Rectangle rectangle = rectangles[i];
      Point minClip = Point(100 + rectangle.x, 100 + rectangle.y);
      Point maxClip = Point(100 + rectangle.x + rectangle.size, 100 + rectangle.y + rectangle.size);

      paint.color = Colors.blueAccent;

      canvas.drawRect(
        Rect.fromPoints(
          Offset(minClip.x, minClip.y),
          Offset(maxClip.x, maxClip.y),
        ),
        paint,
      );

      if (i > 0) {
        int j = i - 1;

        Rectangle clippingRectangle = rectangles[j];
        Point minClip2 = Point(100 + clippingRectangle.x, 100 + clippingRectangle.y);
        Point maxClip2 = Point(100 + clippingRectangle.x + clippingRectangle.size, 100 + clippingRectangle.y + clippingRectangle.size);

        List<Point> clippedLine1 = cohenSutherlandClip(minClip, Point(minClip.x, maxClip.y), minClip2, maxClip2);
        List<Point> clippedLine2 = cohenSutherlandClip(minClip, Point(maxClip.x, minClip.y), minClip2, maxClip2);
        List<Point> clippedLine3 = cohenSutherlandClip(Point(minClip.x, maxClip.y), maxClip, minClip2, maxClip2);
        List<Point> clippedLine4 = cohenSutherlandClip(Point(maxClip.x, minClip.y), maxClip, minClip2, maxClip2);

        paint.color = Colors.black;

        if (clippedLine1.isNotEmpty) {
          canvas.drawLine(Offset(clippedLine1[0].x, clippedLine1[0].y), Offset(clippedLine1[1].x, clippedLine1[1].y), paint);
        }

        if (clippedLine2.isNotEmpty) {
          canvas.drawLine(Offset(clippedLine2[0].x, clippedLine2[0].y), Offset(clippedLine2[1].x, clippedLine2[1].y), paint);
        }

        if (clippedLine3.isNotEmpty) {
          canvas.drawLine(Offset(clippedLine3[0].x, clippedLine3[0].y), Offset(clippedLine3[1].x, clippedLine3[1].y), paint);
        }

        if (clippedLine4.isNotEmpty) {
          canvas.drawLine(Offset(clippedLine4[0].x, clippedLine4[0].y), Offset(clippedLine4[1].x, clippedLine4[1].y), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
