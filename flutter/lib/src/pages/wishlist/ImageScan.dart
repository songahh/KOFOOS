import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pytorch_lite/pytorch_lite.dart';


class ImageScan  {
  ClassificationModel? _imageModel;
  //CustomModel? _customModel;
  ModelObjectDetection? _objectModelYoloV8;

  String? textToShow;
  List? _prediction;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool objectDetection = false;
  List<ResultObjectDetection?> objDetect = [];

  ImageScan();

  Future<void> initializeModel() async {
    String pathObjectDetectionModelYolov8 = "assets/ai/best.torchscript";
    try {
      _objectModelYoloV8 = await PytorchLite.loadObjectDetectionModel(
          pathObjectDetectionModelYolov8, 100, 640, 640,
          labelPath: "assets/ai/labels.txt",
          objectDetectionModelType: ObjectDetectionModelType.yolov8);
      print("모델 로드 성공");
    } catch (e) {
      print("모델 로드 실패: $e");
    }
  }

  /*Future loadModel() async {
    String pathObjectDetectionModelYolov8 = "assets/ai/best.torchscript";
    try {
      _objectModelYoloV8 = await PytorchLite.loadObjectDetectionModel(
          pathObjectDetectionModelYolov8, 100, 640, 640,
          labelPath: "assets/ai/labels.txt",
          objectDetectionModelType: ObjectDetectionModelType.yolov8);
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }*/

// 이미지 파일 리스트를 받아 각 이미지에 대한 객체 탐지를 실행하고 결과를 반환하는 메서드
  Future<List<ResultObjectDetection?>> runObjectDetectionYoloV8(List<File> images) async {
    if (_objectModelYoloV8 == null) {
      print("모델 초기화 실패");
      return [];
    }

    List<ResultObjectDetection?> results = [];
    for (File image in images) {
      print(image);
      print('진단 시작!');
      try {
        List<ResultObjectDetection> detectionResults = await _objectModelYoloV8!.getImagePrediction(
            await image.readAsBytes(),
            minimumScore: 0.8,
            iOUThreshold: 0.6);
        results.addAll(detectionResults);
      } catch (e) {
        print("Object detection failed for image: ${image.path}, Error: $e");
        results.add(null); // 실패한 경우 null 추가
      }
    }
    return results;
  }
  String inferenceTimeAsString(Stopwatch stopwatch) =>
      "Inference Took ${stopwatch.elapsed.inMilliseconds} ms";

  Future runClassification() async {
    objDetect = [];
    //pick a random image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    //get prediction
    //labels are 1000 random english words for show purposes
    print(image!.path);
    Stopwatch stopwatch = Stopwatch()..start();

    textToShow = await _imageModel!
        .getImagePrediction(await File(image.path).readAsBytes());
    textToShow = "${textToShow ?? ""}, ${inferenceTimeAsString(stopwatch)}";

    List<double?>? predictionList = await _imageModel!.getImagePredictionList(
      await File(image.path).readAsBytes(),
    );

    print(predictionList);

  }

}
