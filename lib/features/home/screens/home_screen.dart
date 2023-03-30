import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lanars_test/features/home/widgets/image_tile.dart';
import 'package:lanars_test/models/unsplash_image.dart';

import '../../../blocs/unsplash/unsplash_bloc.dart';
import '../../../sevices/unsplash_api_service.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UnsplashImage> _photos = [];
  int _page = 1;
  final bloc = UnsplashBloc(UnsplashService());
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    _fetchPhotos();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _fetchPhotos() async {
    try {
      List<UnsplashImage> photos = await UnsplashService().getPhotos(_page, 20);
      _photos.addAll(photos);
      bloc.add(UnsplashGetPhotos(await UnsplashService().getPhotos(_page, 20)));
      bloc.add(UnsplashGetPhotos(_photos));
      _page++;
      _isLoading = false;
    } catch (e) {
      _isLoading = false;
    }
  }

  Future refresh() async {
    List<UnsplashImage> photos = await UnsplashService().getPhotos(_page, 20);
    _photos.addAll(photos);
    bloc.add(UnsplashGetPhotos(await UnsplashService().getPhotos(_page, 20)));
    bloc.add(UnsplashGetPhotos(_photos));
  }

  void _scrollListener() {
    if (!_isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _fetchPhotos();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UnsplashBloc(UnsplashService()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Unsplash Lanars",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomNavBar(),
        body: BlocBuilder<UnsplashBloc, UnsplashState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is UnsplashLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UnsplashLoadedState) {
              return RefreshIndicator(
                  onRefresh: refresh,
                  child: GridView.custom(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 6,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: const [
                          QuiltedGridTile(4, 4),
                          QuiltedGridTile(2, 2),
                          QuiltedGridTile(2, 2),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return GestureDetector(
                            child: ImageTile(state.images[index]),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      unsplashImage: _photos[index],
                                    ),
                                  ),
                                  (route) => false);
                            },
                          );
                        },
                        childCount: _photos.length,
                      )));
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
