import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/unsplash/unsplash_bloc.dart';
import '../../../sevices/unsplash_api_service.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final bloc = UnsplashBloc(UnsplashService());
  @override
void initState() {
  lol();
    super.initState();
  }
void lol()async{
    bloc.add(UnsplashGetPhotos(await UnsplashService().getPhotos()));
}

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => UnsplashBloc(UnsplashService()),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: BlocBuilder<UnsplashBloc, UnsplashState>(
            bloc:bloc,
            builder: (context, state) {
              if(state is UnsplashLoadingState)
                {return const CircularProgressIndicator();}
            if(state is UnsplashLoadedState){
              print("kek"+state.images.length.toString());
              return  Image.network(
                  state.images[0].urls!.full);
            }
            return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
