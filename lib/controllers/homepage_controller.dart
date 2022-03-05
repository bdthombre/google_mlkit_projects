import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter_sdk/models/image_screen_ratio.dart';

class HomePageController extends GetxController {
  Rx<XFile> image = XFile("").obs;
  RxList<Face> currentFaces = <Face>[].obs;
  Rx<ImageScreenRatio> currentImageRatio = ImageScreenRatio(1.0, 1.0).obs;

  final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector(
    const FaceDetectorOptions(
      enableClassification: true,
      enableContours: true,
      enableLandmarks: true,
    ),
  );

  Future<ImageScreenRatio> _getDividingValues(imagePath) async {
    double screenX = Get.width;
    double screenY = Get.height;
    var image = await decodeImageFromList(File(imagePath).readAsBytesSync());
    int imageX = image.width;
    int imageY = image.height;

    Get.log("Screen size: $screenX X $screenY");
    Get.log("Image size: $imageX X $imageY ");
    ImageScreenRatio imageScreenRatio =
        ImageScreenRatio(imageX / screenX, imageY / screenY);
    imageScreenRatio.printInfo();
    currentImageRatio.value = imageScreenRatio;
    return imageScreenRatio;
  }

  Future<void> getFaces(XFile inputXFile) async {
    if (inputXFile.path == image.value.path) {
      InputImage inputImage = InputImage.fromFilePath(inputXFile.path);

      final List<Face> faces = await _faceDetector.processImage(inputImage);
      Get.log("Number of faces detected: ${faces.length}");
      Get.log(faces.first.boundingBox.toString());
      currentFaces.value = faces;
      await _getDividingValues(inputXFile.path);
    }
  }
}

// Uint8List imageBytes = await image.readAsBytes();
//
// InputImageData imageData = InputImageData(
//     size: null, imageRotation: null, inputImageFormat: null, planeData: []);
//
// InputImage inputImage =
//     InputImage.fromBytes(bytes: imageBytes, inputImageData: imageData);
