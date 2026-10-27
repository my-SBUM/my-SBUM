import 'package:flutter/material.dart';

/// Memilih sumber gambar lokal atau jaringan berdasarkan format path.
class AppImage extends StatelessWidget {
  const AppImage(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.loadingBuilder,
    this.errorBuilder,
  });

  final String source;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageLoadingBuilder? loadingBuilder;
  final ImageErrorWidgetBuilder? errorBuilder;

  @override
  Widget build(BuildContext context) {
    if (source.startsWith('assets/')) {
      return Image.asset(
        source,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        errorBuilder: errorBuilder,
      );
    }

    return Image.network(
      source,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
    );
  }
}
