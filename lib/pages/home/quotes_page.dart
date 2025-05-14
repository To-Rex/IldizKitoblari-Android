import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';

class QuotesPage extends StatelessWidget {
  QuotesPage({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ApiController().getBanner(1,3);
    return Scaffold(
      appBar: AppBar(
          title: Text('Quotes',
              style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
            onPressed: () {
              Get.back();
            },
          )),
      body: Expanded(
          child:  Center(child: Text('Ma`lumotlar yo`q!', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600))),
      )
    );
  }
}
