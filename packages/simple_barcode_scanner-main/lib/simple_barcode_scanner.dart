library simple_barcode_scanner;

import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/screens/shared.dart';
import 'package:kofoos/src/pages/search/search_detail_page.dart';
import 'package:kofoos/src/pages/camera/camera_detail_view.dart';
import 'package:kofoos/src/pages/search/api/search_api.dart';

export 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class SimpleBarcodeScannerPage extends StatefulWidget {
  ///Barcode line color default set to #ff6666
  final String lineColor;

  ///Cancel button text while scanning
  final String cancelButtonText;

  ///Flag to show flash icon while scanning or not
  final bool isShowFlashIcon;

  ///Enter enum scanType, It can be BARCODE, QR, DEFAULT
  final ScanType scanType;

  ///AppBar Title
  final String? appBarTitle;

  ///center Title
  final bool? centerTitle;

  final Widget? child;

  @override
  _SimpleBarcodeScannerPageState createState() => _SimpleBarcodeScannerPageState();

  /// appBatTitle and centerTitle support in web and window only
  /// Remaining field support in only mobile devices
  SimpleBarcodeScannerPage({
    Key? key,
    this.lineColor = "#ff6666",
    this.cancelButtonText = "Cancel",
    this.isShowFlashIcon = false,
    this.scanType = ScanType.barcode,
    this.appBarTitle,
    this.centerTitle,
    this.child,
  }) : super(key: key);

}

class _SimpleBarcodeScannerPageState extends State<SimpleBarcodeScannerPage>{




  // void showOverlayButton() async {
  //   if (await FlutterOverlayWindow.isPermissionGranted()) {
  //     await FlutterOverlayWindow.showOverlay(
  //       height: 60,
  //       width: 60,
  //       alignment: OverlayAlignment.bottomRight,
  //       overlayTitle: "Scan",
  //       overlayContent: "Tap to scan",
  //       enableDrag: false,
  //     );
  //   } else {
  //     bool? isGranted = await FlutterOverlayWindow.requestPermission();
  //     if (isGranted ?? false) {
  //       await FlutterOverlayWindow.showOverlay(
  //         height: 60,
  //         width: 60,
  //         alignment: OverlayAlignment.bottomRight,
  //         overlayTitle: "Scan",
  //         overlayContent: "Tap to scan",
  //         enableDrag: false,
  //       );
  //     }
  //   }
  // }

  Key scannerKey = UniqueKey();

  void restartScanner() {
    setState(() {
      scannerKey = UniqueKey();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            BarcodeScanner(
              lineColor: widget.lineColor,
              cancelButtonText: widget.cancelButtonText,
              isShowFlashIcon: widget.isShowFlashIcon,
              scanType: widget.scanType,
              appBarTitle: widget.appBarTitle,
              centerTitle: widget.centerTitle,
              onScanned: (res) async {
                SearchApi searchApi = SearchApi();
                var item = await searchApi.getProductByBarcode(res);
                if (item != null && item['name'] != "-") {
                  print("Product found: " + item.toString());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraDetailView(
                        itemNo: item['itemNo'],
                      ),
                    ),
                  );
                } else if (res != "-1" && item['name'] == "-") {
                  print("No matched product: " + res);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('There is no matched product'),
                    ),
                  );

                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SimpleBarcodeScannerPage()),
                    );
                  });
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            Positioned(
              right: 30,
              bottom: 30,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SimpleBarcodeScannerPage()),
                  );
                },
                child: Icon(Icons.barcode_reader),
                backgroundColor: Color(0xffECECEC),
                foregroundColor: Color(0xff343F56),
              ),
            )
          ],
        )
    );

  }
}
