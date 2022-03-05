import 'package:get/get.dart';

class ImageScreenRatio {
  final double x;
  final double y;

  ImageScreenRatio(this.x, this.y);

  void printInfo() {
    Get.log("The x and y ratios to this image is : $x and $y");
    Get.log("Pixel Ratio: ${Get.pixelRatio}");
  }
}
