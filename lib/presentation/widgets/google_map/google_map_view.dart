// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class GoogleMapWebView extends StatelessWidget {
//   final double latitude;
//   final double longitude;
//
//   GoogleMapWebView({required this.latitude, required this.longitude});
//
//   @override
//   Widget build(BuildContext context) {
//
//     InAppWebViewController? webView;
//     final String googleMapUrl =
//         'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Map View"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url:WebUri(Uri.parse(googleMapUrl).toString())),
//         onWebViewCreated: (InAppWebViewController controller) {
//           webView = controller;
//         },
//         onLoadError: (controller, url, code, message) {
//           print("Failed to load $url: $message");
//         },
//         onLoadHttpError: (controller, url, statusCode, description) {
//           print("HTTP error: $statusCode, $description");
//         },
//       ),
//     );
//   }
// }
//
// class WebView {
// }
