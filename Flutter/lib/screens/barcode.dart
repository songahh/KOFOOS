// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:kofoos/provider/scan_check.dart';
// import 'package:shake/shake.dart';
// import 'package:provider/provider.dart';
//
//
//
// class Barcode extends StatefulWidget {
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
//
// class _MyAppState extends State<Barcode> {
//   String _scanBarcode = 'Unknown';
//   @override
//   void initState() {
//     super.initState();
//     ShakeDetector detector = ShakeDetector.autoStart(
//         onPhoneShake: (){
//
//           if(!Provider.of<Scanning>(context,listen: false).scanning){
//             print(Provider.of<Scanning>(context,listen: false).scanning);
//             Provider.of<Scanning>(context,listen: false).start();
//             scanBarcodeNormal();
//           }
//         },
//         minimumShakeCount: 1,
//         shakeSlopTimeMS: 500,
//         shakeCountResetTime: 3000,
//         shakeThresholdGravity: 2.7,
//     );
//   }
//
//   Future<void> startBarcodeScanStream() async {
//     FlutterBarcodeScanner.getBarcodeStreamReceiver(
//         '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
//         .listen((barcode) => print(barcode));
//   }
//
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> scanBarcodeNormal() async {
//
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.BARCODE);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       Provider.of<Scanning>(context,listen: false).end();
//       // print("move to detail");
//       return;
//     }
//
//     setState(() {
//       _scanBarcode = barcodeScanRes;
//       Provider.of<Scanning>(context,listen: false).end();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             backgroundColor: Colors.amber,
//             appBar: AppBar(title: const Text('Barcode scan'),
//             backgroundColor: Colors.amber),
//             body: Builder(builder: (BuildContext context) {
//               return Container(
//                   alignment: Alignment.center,
//                   child: Flex(
//                       direction: Axis.vertical,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text('Scan result : $_scanBarcode\n',
//                             style: TextStyle(fontSize: 20))
//                       ]));
//             })));
//   }
// }
