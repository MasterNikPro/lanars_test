import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lanars_test/blocs/search/search_bloc.dart';
import 'package:lanars_test/features/home/screens/detail_screen_search.dart';
import 'package:lanars_test/features/home/widgets/image_tile_search.dart';
import 'package:lanars_test/models/unsplash_api_search.dart';
import 'package:lanars_test/sevices/unsplash_api_search_service.dart';

import '../../../models/unsplash_image.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<UnsplashImageSearch> _photos = [];
  int _page = 1;
  final bloc = SearchBloc();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  late String _keyword = "";
  late List<UnsplashImage> images;
  TextEditingController tx= new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _fetchPhotos();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _fetchPhotos() async {
    print("key"+_keyword);
    List<UnsplashImageSearch?>? photos =
        await UnsplashServiceSearch().getPhotos(_page, 20, _keyword);

    _photos.addAll(photos as Iterable<UnsplashImageSearch>);
    bloc.add(LoadedSearchImagesEvent(
        await UnsplashServiceSearch().getPhotos(_page, 20, _keyword),_keyword));
    bloc.add(LoadedSearchImagesEvent(_photos,_keyword));
    print(photos);
    _page++;
    _isLoading = false;
  }

  void _scrollListener() {
    if (!_isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _fetchPhotos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
        backgroundColor: Colors.grey[50],
        body: Column(
          children: [
             Container(
               decoration: BoxDecoration(
                   border: Border.all(
                     color: Colors.grey,
                   ),
                   borderRadius: const BorderRadius.all(Radius.circular(20))
               ),
               height: 50,
               child: TextField(
                 controller: tx,
                 onSubmitted: (String text)async{

                   _keyword=tx.text;
                   _photos.clear();
                   _fetchPhotos();

                 },
               ),
             ),
            Container(
              child: BlocBuilder<SearchBloc, SearchState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is LoadedSearchImagesState) {
                    return _photos.length==0?const Center(child: Text("Search New Image")):Expanded(
                        child: GridView.custom(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
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
                              return   GestureDetector(
                                  child: ImageTileSearch(state.images![index]!),
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreenSearch(
                                            unsplashImage: state.images![index],
                                          ),
                                        ),
                                            (route) => false);
                                  },
                                );
                              },
                              childCount: _photos.length,
                            )));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
