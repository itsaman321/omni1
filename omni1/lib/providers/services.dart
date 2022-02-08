import 'dart:io';

import 'package:tflite/tflite.dart';

class GenderClassification {
  Future classifyImage(File image1, File image2) async {
    var output1 = await Tflite.runModelOnImage(
      path: image1.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );
    var output2 = await Tflite.runModelOnImage(
      path: image2.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );
    return {
      '1': output1,
      '2': output2,
    };
  }

  Future loadModel() async {
    await Tflite.loadModel(
      model: "assets/model/model_unquant.tflite",
      labels: 'assets/model/labels.txt',
      numThreads: 1,
    );
  }

  void dispose() {
    Tflite.close();
  }
}
