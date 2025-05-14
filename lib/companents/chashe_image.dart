import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  final String keys;
  final String url;
  final BoxFit? fit;
  final double? radius;
  const CacheImage({super.key, required this.keys, required this.url, this.fit = BoxFit.contain, this.radius});

  @override
  Widget build(BuildContext context) {
    return DisposableCachedImage.network(
        imageUrl: url,
        fit: fit,
        borderRadius: BorderRadius.circular(radius ?? 0),
        onLoading: (context, one, two) => Image.asset('assets/images/default.png', fit: BoxFit.scaleDown),
        progressBuilder: (context, progress) => Image.asset('assets/images/default.png', fit: BoxFit.scaleDown),
        onError: (context, error, stackTrace, retryCall) => Center(child: Image.asset('assets/images/default.png', fit: BoxFit.scaleDown)),
        onImage: (context, imageWidget, height, width) => imageWidget
    );
  }
}