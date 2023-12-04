import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDisplayNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final bool? isPreGenerating;

  const CustomDisplayNetworkImage(
      {super.key,
      required this.imageUrl,
      this.width,
      this.height,
      this.isPreGenerating = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(
        key: ValueKey(imageUrl),
        useOldImageOnUrlChange: true,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
        placeholder: (context, url) => isPreGenerating!
            ? const SizedBox()
            : const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
