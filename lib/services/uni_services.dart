import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../controllers/get_controller.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController controller;
  final GetController _getController = Get.put(GetController());

  String generatePaymentUrl() {
    final merchantId = '664c890b70ee2ef365a80e85';
    final orderId = 'TESTORDER';
    final amount = 10000; // Amount in tiyin
    final urlParams = 'm=$merchantId;ac.order_id=$orderId;a=$amount';
    final encodedParams = base64.encode(utf8.encode('m=664c890b70ee2ef365a80e85;ac.order_id=TESTORDER;ac.full_name=${_getController.meModel.value.data!.result?.fullName};ac.phone=${_getController.meModel.value.data!.result?.phone};a=10000;c=https://ildizkitoblari.uz'));
    print('https://checkout.paycom.uz/$encodedParams');
    return 'https://checkout.paycom.uz/$encodedParams';
    //var data = base64.encode(utf8.encode('m=664c890b70ee2ef365a80e85;ac.order_id=TESTORDER;ac.full_name=${_getController.meModel.value.data!.result?.fullName};ac.phone=${_getController.meModel.value.data!.result?.phone};a=10000;c=https://encryptpy.onrender.com/api/count'));
    //
  }


  @override
  void initState() {
    super.initState();
    final paymentUrl = generatePaymentUrl();
    controller = WebViewController();
    controller.loadRequest(Uri.parse(paymentUrl));
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('progress: $progress');
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            print('body: ${controller.currentUrl()}');
            //print('body: $body');
          },
          onPageFinished: (String url) {
            //body = document.querySelector('body').outerHTML;
            print('Page finished loading: $url');
            //print('body: $body');
            print('body: ${controller.currentUrl()}');
            if (url.contains('success')) {
              _handlePaymentSuccess();
            } else if (url.contains('failure')) {
              _handlePaymentFailure();
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel('PaycomChannel', onMessageReceived: (message) {
        if (message.message == 'paymentSuccess') {
          _handlePaymentSuccess();
        } else if (message.message == 'paymentFailure') {
          _handlePaymentFailure();
        } else {
          _handlePaymentSuccess();
        }
      });
  }

  void _handlePaymentSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your payment was successful.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _handlePaymentFailure() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Failed'),
          content: Text('Your payment has failed. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(controller: controller),
    );
  }
}
