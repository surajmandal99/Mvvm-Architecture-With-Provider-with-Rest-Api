

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/respository/home_api/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {

  HomeRepository  homeRepository ;
  HomeViewViewModel({required this.homeRepository});

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response){
    moviesList = response ;
    notifyListeners();
  }


  Future<void> fetchMoviesListApi ()async{

    setMoviesList(ApiResponse.loading());

    homeRepository.fetchMoviesList().then((value){
      setMoviesList(ApiResponse.completed(value));

    }).onError((error, stackTrace){
      if (kDebugMode) {
        print(error);
        print(stackTrace);
      }
      setMoviesList(ApiResponse.error(error.toString()));

    });
  }


}