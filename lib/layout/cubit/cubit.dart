import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';

import '../../modules/science/science_screen.dart';
import '../../modules/settings_screen/settings_screen.dart';
import '../../modules/sports/sports_screen.dart';
import '../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
  //  BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }


  List<dynamic> business = [];

  void getBusiness() {
    if (business.length == 0) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        path: pathUrl,
        query: businessQuery,
      ).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    if (sports.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        path: pathUrl,
        query: sportsQuery,
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSucessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSucessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.length == 0) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        path: pathUrl,
        query: scienceQuery,
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSucessState());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSucessState());
    }
  }

  // start search
  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      path: pathSearch,
      query: searchQuery(value),
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSucessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }










      // DioHelper.getData(
      //     path: '',
      //   //  query: businessQuery,

    //   ).then((value) {
    //     business = value.data['articles'];
    //     emit(NewsGetBusinessSuccessState());
    //   }).catchError((error) {
    //     emit(NewsGetBusinessErrorState(error.toString()));
    //   });
    // } else {
    //   emit(NewsGetBusinessSuccessState());
      // emit(NewsGetBusinessLoadingState());

      //  DioHelper.getData(
      // url: 'https://reqres.in/api/users?id=3'

      // ).then((value) {
      // print(value.data['articles'][0]['title']);
      // business = value.data['articles'];
      // print(business [0]['title']);
      //
      // emit(NewsGetBusinessSuccessState());
      //   }).catchError((error) {
      //     print(error.toString());
      //     emit(NewsGetBusinessErrorState(error.toString()));
      //   });
      // }
    }
  }
}
