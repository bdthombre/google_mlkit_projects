import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class BasePainter extends CustomPainter {
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // TODO: implement paint
  }
}

class FaceDetectorPainter extends CustomPainter {
  final Size absoluteImageSize;
  final List<Face> faces;

  FaceDetectorPainter(this.absoluteImageSize, this.faces);

  FaceDetectorPainter.base(this.absoluteImageSize, this.faces);

  @override
  void paint(Canvas canvas, Size size) async {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    final Paint greenPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.green;

    for (final Face face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          face.boundingBox.left * scaleX,
          face.boundingBox.top * scaleY,
          face.boundingBox.right * scaleX,
          face.boundingBox.bottom * scaleY,
        ),
        greenPaint,
      );

      final contour = face.getContour((FaceContourType.face));
      if (contour != null) {
        canvas.drawPoints(
            ui.PointMode.points,
            contour.positionsList
                .map((offset) =>
                    Offset((offset.dx * scaleX), offset.dy * scaleY))
                .toList(),
            paint);
      }

      /*for (int i = 0; i < contour.positionsList.length - 1; i++) {
        canvas.drawLine(contour.positionsList[i].scale(scaleX, scaleY),
            contour.positionsList[i + 1].scale(scaleX, scaleY), paint);
      }*/
      // for (final connection in faceMaskConnections) {
      //   canvas.drawLine(
      //       contour.positionsList[connection.x].scale(scaleX, scaleY),
      //       contour.positionsList[connection.y].scale(scaleX, scaleY),
      //       paint);
      // }

    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.faces != faces;
  }
}
