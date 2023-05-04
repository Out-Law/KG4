import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CanvasWidget extends StatefulWidget {

  CanvasWidget({Key? key})
      : super(key: key);

  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      willChange: true,
      painter: CanvasPainter(),
    );
  }
}


class CanvasPainter extends CustomPainter{
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

}