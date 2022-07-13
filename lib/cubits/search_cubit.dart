import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/models/search_model.dart';
import 'package:shopping_app/shared/local/const.dart';
import 'package:shopping_app/shared/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
SearchCubit() : super(SearchInitialState());

static SearchCubit get(BuildContext context) => BlocProvider.of(context);

SearchModel? searchResult;

void productSearch({required String text}) {
  emit(GetSearchResultsLoadingState());
  DioHelper.postData(
    url: "products/search",
    token: Constant.token,
    data: {
      "text":text,
    },
  ).then((value) {
    searchResult=SearchModel.fromJson(value.data);
    emit(GetSearchResultsSuccessState());
    print(searchResult!.data!.data![0].name);
  }).catchError((error){
    emit(GetSearchResultsErrorState());
    print(error.toString());
  });
}
}

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class GetSearchResultsLoadingState extends SearchStates{}
class GetSearchResultsSuccessState extends SearchStates{}
class GetSearchResultsErrorState extends SearchStates{}