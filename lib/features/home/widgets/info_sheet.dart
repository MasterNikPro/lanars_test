import 'package:flutter/material.dart';

import '../../../models/unsplash_image.dart';

class InfoSheet extends StatelessWidget {
  final UnsplashImage? _image;

  InfoSheet(this._image, {super.key});

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(top: 16.0),
        elevation: 10.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: _image != null
                ? <Widget>[
                    Row(
                      children: <Widget>[
                        _buildUserProfileImage(
                            _image!.user!.profileImage!.medium),
                        Text(
                          '${_image!.user!.name}\n',
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            '${_image!.createdAt}'.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black26,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    _buildLocationWidget(_image!.user!.location as String)
                        as Widget,
                  ].where((w) => w != null).toList()
                : <Widget>[const CircularProgressIndicator()]),
      );

  Widget _buildUserProfileImage(String url) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(url),
        ),
      );

  Widget? _buildLocationWidget(String location) => location != null
      ? Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
          child: Row(
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black54,
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    location.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        )
      : null;
}
