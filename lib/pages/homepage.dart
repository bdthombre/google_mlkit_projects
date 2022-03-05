import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter_sdk/widgets/face_detector_painter.dart';

import '../controllers/homepage_controller.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({Key? key}) : super(key: key);
  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google ML Kit- New SDK"),
      ),
      body: Obx(() {
        if (controller.image.value.path == "") {
          return Column(
            children: const [
              Flexible(
                  flex: 1, child: Center(child: Text("No image there yet"))),
              Flexible(
                flex: 5,
                child: Placeholder(),
              ),
              Flexible(
                flex: 1,
                child: SizedBox.expand(),
              ),
            ],
          );
        } else {
          if (controller.currentFaces.isNotEmpty) {
            //List<double> xy = controller.getDividingValues(controller)
            return Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Center(
                        child:
                            Text(controller.image.value.path.split('/').last))),
                Flexible(
                  flex: 5,
                  // child:
                  // Container(
                  //   constraints: const BoxConstraints.expand(),
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //           image: Image.file(File(controller.image.value.path))
                  //               .image,
                  //           fit: BoxFit.fitWidth)),
                  child: CustomPaint(
                    child: Image.file(
                      File(
                        controller.image.value.path,
                      ),
                    ),
                    foregroundPainter: FaceDetectorPainter(),
                  ),
                ),
                // Flexible(
                //   flex: 5,
                //   child: Stack(children: [
                //     Image.file(File(controller.image.value.path)),
                //     Positioned(
                //       //(258.0, 254.0, 687.0, 683.0)
                //       // left: (controller.currentFaces.first.boundingBox.left /
                //       //     1.75),
                //       // top: (controller.currentFaces.first.boundingBox.top /
                //       //     2.27),
                //       left: 70, top: 32,
                //       // left:
                //       //     controller.currentFaces.first.boundingBox.left / 1.75,
                //       //top: controller.currentFaces.first.boundingBox.top / 2.27,
                //       // bottom: controller.currentFaces.first.boundingBox.bottom,
                //       // right: controller.currentFaces.first.boundingBox.right,
                //       child: Container(
                //         color: Colors.blue.withOpacity(0.5),
                //         width:
                //             (controller.currentFaces.first.boundingBox.width /
                //                 2.27),
                //         height:
                //             (controller.currentFaces.first.boundingBox.height /
                //                 1.75),
                //       ),
                //     )
                //   ]),
                // ),
                const Flexible(
                  flex: 1,
                  child: SizedBox.expand(),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //Get.log("Initial Path: ${controller.image.value.path.toString()}");
          XFile? image = await _picker.pickImage(source: ImageSource.gallery);
          if (image != null) controller.image.value = image;
          //Get.log(controller.image.value.path);
          await controller.getFaces(controller.image.value);
          //await controller.getDividingValues(controller.image.value.path);
        },
        child: const Icon(Icons.image_search),
      ),
    );
  }
}
