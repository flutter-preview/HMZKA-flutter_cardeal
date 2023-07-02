part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppLoginLoadingState extends AppState {}

class AppLoginSuccessState extends AppState {}

class AppLoginErrorState extends AppState {}

class AppRegisterLoadingState extends AppState {}

class AppRegisterSuccessState extends AppState {}

class AppRegisterErrorState extends AppState {}

class AppGetCategoriesLoadingState extends AppState {}

class AppGetCategoriesSuccessState extends AppState {}

class AppGetCategoriesErrorState extends AppState {}

class AppGetCarsLoadingState extends AppState {}

class AppGetCarsSuccessState extends AppState {}

class AppGetCarsErrorState extends AppState {}

class AppGetMyCarsLoadingState extends AppState {}

class AppGetMyCarsSuccessState extends AppState {}

class AppGetMyCarsErrorState extends AppState {}

class AppGetPriceCarLoadingState extends AppState {}

class AppGetPriceCarSuccessState extends AppState {}

class AppGetPriceCarErrorState extends AppState {}

class AppAddCarCarLoadingState extends AppState {}

class AppAddCarCarSuccessState extends AppState {}

class AppAddCarCarErrorState extends AppState {}

class AppGetCategoryDetailLoadingState extends AppState {}

class AppGetCategoryDetailSuccessState extends AppState {}

class AppGetCategoryDetailErrorState extends AppState {}

class AppGetUserCarLoadingState extends AppState {}

class AppGetUserCarSuccessState extends AppState {}

class AppGetUserCarErrorState extends AppState {}

class AppSearchCarLoadingState extends AppState {}

class AppSearchCarSuccessState extends AppState {}

class AppSearchCarErrorState extends AppState {}

class AppSearchCarPartLoadingState extends AppState {}

class AppSearchCarPartSuccessState extends AppState {}

class AppSearchCarPartErrorState extends AppState {}
