import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

import '../search/api/search_api.dart';
import '../search/search_detail_page.dart';
import 'box_widget.dart';
import 'camera_view.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);


  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  List<ResultObjectDetection>? results;
  Duration? objectDetectionInferenceTime;

  String? classification;
  Duration? classificationInferenceTime;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback, resultsCallbackClassification),

          // Bounding boxes
          boundingBoxes2(results),

        ],
      ),
    );
  }


  void showSnackBar(BuildContext context, List<ResultObjectDetection>? results) async {
    if (results == null || results.isEmpty) {
      return;
    }
    String? itemNo;
    bool showMoreDetail = false;
    SearchApi searchApi = SearchApi();
    dynamic data;

    for (var result in results) {
      if (result.score > 0.75) {
        itemNo = result.className?.split("_")[0];
        showMoreDetail = true;
        break;
      }
    }

    if (itemNo != null) {
      data = await searchApi.getProductDetail(itemNo);
    }

  if (showMoreDetail && data != null) {
    final snackBar = SnackBar(
      content: Container(
        height: 250.0,
        child: Center(
          child: GestureDetector(
            onTap: (){
              CameraController? cameraController;
              cameraController!.stopImageStream();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ProductDetailView(
                itemNo: data['itemNo'],
              ),
              )).then((value) =>
                cameraController?.startImageStream((image) {
                  onLatestImageAvailable;})
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Is this the right product?", style: TextStyle(fontSize: 20.0),),
                Image.network(data['imgurl'],height: 200),
                ],
              ),
          ),
          ),
      ),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
      ),
  );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget boundingBoxes2(List<ResultObjectDetection>? results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results.map((e) => BoxWidget(result: e)).toList(),
    );
  }

  void resultsCallback(List<ResultObjectDetection> results, Duration inferenceTime) {
    if (!mounted) {
      return;
    }
    setState(() {
      this.results = results;
      objectDetectionInferenceTime = inferenceTime;
      for (var element in results) {
        print({
          "rect": {
            "left": element.rect.left,
            "top": element.rect.top,
            "width": element.rect.width,
            "height": element.rect.height,
            "right": element.rect.right,
            "bottom": element.rect.bottom,
          },
        });
      }
    });
    showSnackBar(context, results);
  }

  void resultsCallbackClassification(String classification, Duration inferenceTime) {
    if (!mounted) {
      return;
    }
    setState(() {
      this.classification = classification;
      classificationInferenceTime = inferenceTime;
    });
  }

}

