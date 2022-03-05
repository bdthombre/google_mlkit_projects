import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter_sdk/widgets/face_detector_painter.dart';

class HomePageController extends GetxController {
  Rx<XFile> image = XFile("").obs;

  ///RELATED TO FACE DETECTION
  final RxList<Face> currentFaces = <Face>[].obs;
  final Rx<Size> currentImageSize = const Size(1.0, 1.0).obs;
  Rx<FaceDetectorPainter> currentFaceDetectorPainter =
      FaceDetectorPainter(const Size(1.0, 1.0), <Face>[]).obs;

  final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector(
    const FaceDetectorOptions(
      enableClassification: true,
      enableContours: true,
      enableLandmarks: false,
    ),
  );

  Future<void> getFaces(XFile inputXFile) async {
    if (inputXFile.path == image.value.path) {
      InputImage inputImage = InputImage.fromFilePath(inputXFile.path);

      //Get image width and height
      var image =
          await decodeImageFromList(File(inputXFile.path).readAsBytesSync());
      int imageX = image.width;
      int imageY = image.height;
      currentImageSize.value = Size(imageX.toDouble(), imageY.toDouble());

      //Get faces information from the image
      final List<Face> faces = await _faceDetector.processImage(inputImage);
      Get.log("Number of faces detected: ${faces.length}");
      Get.log(faces.first.boundingBox.toString());
      currentFaces.value = faces;

      currentFaceDetectorPainter.value =
          FaceDetectorPainter(currentImageSize.value, currentFaces);
      //await _getDividingValues(inputXFile.path);
    }
  }

  ///RELATED TO TEXT DETECTION
  ///
  ///
  final RxList<TextBlock> currentTextBlocks = <TextBlock>[].obs;
  final TextDetectorV2 _textDetectorV2 = GoogleMlKit.vision.textDetectorV2();

  Future<void> getTexts(XFile inputXFile) async {
    if (inputXFile.path == image.value.path) {
      InputImage inputImage = InputImage.fromFilePath(inputXFile.path);

      //Get image width and height
      var image =
          await decodeImageFromList(File(inputXFile.path).readAsBytesSync());
      int imageX = image.width;
      int imageY = image.height;
      currentImageSize.value = Size(imageX.toDouble(), imageY.toDouble());

      //Process the image
      final texts = await _textDetectorV2.processImage(
        inputImage,
      );
      if (texts.blocks.isNotEmpty) {
        currentTextBlocks.value = texts.blocks;
        for (TextBlock block in texts.blocks) {
          Get.log(block.text);
        }
      }
    }
  }

  ///Object Detector
  final ObjectDetector _objectDetector =
      GoogleMlKit.vision.objectDetector(ObjectDetectorOptions(
    classifyObjects: true,
    trackMutipleObjects: true,
  ));
  RxList<DetectedObject> currentObjects = <DetectedObject>[].obs;

  Future<void> getObjects(XFile inputXFile) async {
    if (inputXFile.path == image.value.path) {
      InputImage inputImage = InputImage.fromFilePath(inputXFile.path);

      //Get image width and height
      var image =
          await decodeImageFromList(File(inputXFile.path).readAsBytesSync());
      int imageX = image.width;
      int imageY = image.height;
      currentImageSize.value = Size(imageX.toDouble(), imageY.toDouble());

      //Process image
      final objects = await _objectDetector.processImage(inputImage);
      if (objects.isNotEmpty) {
        currentObjects.value = objects;
        for (DetectedObject object in objects) {
          Get.log("/////////////OBJECT LABELS: ////////////////");
          Get.log(object.getLabels().toString());
        }
      }
    }
  }
} //MAIN

// Uint8List imageBytes = await image.readAsBytes();
//
// InputImageData imageData = InputImageData(
//     size: null, imageRotation: null, inputImageFormat: null, planeData: []);
//
// InputImage inputImage =
//     InputImage.fromBytes(bytes: imageBytes, inputImageData: imageData);

// Future<ImageScreenRatio> _getDividingValues(imagePath) async {
//   double screenX = Get.width;
//   double screenY = Get.height;
//   var image = await decodeImageFromList(File(imagePath).readAsBytesSync());
//   int imageX = image.width;
//   int imageY = image.height;
//
//   Get.log("Screen size: $screenX X $screenY");
//   Get.log("Image size: $imageX X $imageY ");
//   ImageScreenRatio imageScreenRatio =
//       ImageScreenRatio(imageX / screenX, imageY / screenY);
//   imageScreenRatio.printInfo();
//   return imageScreenRatio;
// }
