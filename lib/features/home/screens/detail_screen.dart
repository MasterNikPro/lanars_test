import 'package:flutter/material.dart';
import 'package:lanars_test/features/home/widgets/info_sheet.dart';
import 'package:lanars_test/models/unsplash_image.dart';
import 'package:photo_view/photo_view.dart';

class DetailScreen extends StatefulWidget {
  final UnsplashImage? unsplashImage;

  const DetailScreen({Key? key, required this.unsplashImage}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  @override
  void initState() {
    //_showPersistantBottomSheetCallBack = _showInfoBottomSheet;
    // TODO: implement initState
    //if (infoBottomSheetController != null) _showInfoBottomSheet();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
bool isChecked=false;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('key'),
      onDismissed: (_) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
      direction: DismissDirection.vertical,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            _buildPhotoView(widget.unsplashImage!.id as String,
                widget.unsplashImage!.urls!.regular),
            // wrap in Positioned to not use entire screen
            Positioned(top: 0.0, left: 0.0, right: 0.0, child: _buildAppBar()),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoView(String imageId, String imageUrl) => Hero(
        tag: imageId,
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          initialScale: PhotoViewComputedScale.covered,
          minScale: PhotoViewComputedScale.covered,
          maxScale: PhotoViewComputedScale.covered,
          loadingBuilder: (context, event) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
              ),
            );
          },
        ),
      );

  Widget _buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading:
            // back button
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {}),
        actions: <Widget>[
          // show image info
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            tooltip: 'Image Info',
            onPressed: () {

              if(isChecked){
                Navigator.pop(context);
                isChecked=false;
              }else{
                isChecked=true;
                _showInfoBottomSheet(context);
              }

            },
          ),
        ],
      );

  _showInfoBottomSheet(BuildContext context) {
    print(_scaffoldKey.currentState);
    _scaffoldKey.currentState!.showBottomSheet<void>((context) {
      return new InfoSheet(widget.unsplashImage);
    });
    _scaffoldKey.currentState!.showBottomSheet((context) {
      return new InfoSheet(widget.unsplashImage);
    });
  }
}
