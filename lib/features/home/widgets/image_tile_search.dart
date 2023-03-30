import 'package:flutter/material.dart';
import 'package:lanars_test/models/unsplash_api_search.dart';

import '../../../models/unsplash_image.dart';

class ImageTileSearch extends StatelessWidget {
  final UnsplashImageSearch image;

  const ImageTileSearch(this.image);

  /// Adds rounded corners to a given [widget].
  Widget _addRoundedCorners(Widget widget) =>
      // wrap in ClipRRect to achieve rounded corners
  ClipRRect(borderRadius: BorderRadius.circular(12), child: widget);

  /// Returns a placeholder to show until an image is loaded.
  Widget _buildImagePlaceholder({required UnsplashImageSearch image}) => Container(
    color: image != null
        ? Color(int.parse(image.color!.substring(1, 7), radix: 16) +
        0x64000000)
        : Colors.grey[200],
  );

  /// Returns a error placeholder to show until an image is loaded.
  Widget _buildImageErrorWidget() => Container(
      color: Colors.grey[200],
      child: Center(child: Icon(Icons.broken_image, color: Colors.grey[400])));

  @override
  Widget build(BuildContext context) => InkWell(
    // Hero Widget for Hero animation with [ImagePage]
    child: image != null
        ? Hero(
      tag: '${image.id}',
      child: _addRoundedCorners(
        Image.network(image.urls!.small,
          fit: BoxFit.fill,
        ),
      ),
    )
        : _buildImagePlaceholder(image: image),
  );
}
