import 'package:flutter/material.dart';

import '../../../models/unsplash_image.dart';

class ImageTile extends StatelessWidget {
  final UnsplashImage image;

  const ImageTile(this.image);
  Widget _addRoundedCorners(Widget widget) =>

      ClipRRect(borderRadius: BorderRadius.circular(12), child: widget);

  Widget _buildImagePlaceholder({required UnsplashImage image}) => Container(
        color: image != null
            ? Color(int.parse(image.color!.substring(1, 7), radix: 16) +
                0x64000000)
            : Colors.grey[200],
      );

  @override
  Widget build(BuildContext context) => InkWell(
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
