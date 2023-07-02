import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cardeal/app_cache.dart';
import 'package:flutter_cardeal/dio_helper.dart';
import 'package:flutter_cardeal/models/car_model.dart';
import 'package:flutter_cardeal/models/car_part_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  AppCubit get(context) => BlocProvider.of(context);

  login({required String email, required String password}) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
        path: "user/token/",
        data: {"email": email, "password": password}).then((value) {
      CacheHelper.setString(key: "token", value: value?.data["token"]);
      CacheHelper.setString(key: "name", value: value?.data["name"]);
      CacheHelper.setString(key: "email", value: value?.data["email"]);
      CacheHelper.setString(key: "id", value: "${value?.data["id"]}");
      emit(AppLoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorState());
    });
  }

  register(
      {required String email, required String password, required String name}) {
    emit(AppRegisterLoadingState());
    DioHelper.postData(
            path: "user/create/",
            data: {"email": email, "password": password, "name": name})
        .then((value) {
      print(value?.data);
      CacheHelper.setString(key: "name", value: value?.data["name"]);
      CacheHelper.setString(key: "email", value: value?.data["email"]);
      CacheHelper.setString(key: "id", value: "${value?.data["id"]}");
      emit(AppRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppRegisterErrorState());
    });
  }

//================================================================================================
  List<CarModel> cars = [];
  getCars() {
    emit(AppGetCarsLoadingState());
    DioHelper.getData(path: "car/car-list/").then((value) {
      print(value?.data);
      value?.data.forEach((e) {
        cars.add(CarModel.fromJson(e));
      });
      emit(AppGetCarsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetCarsErrorState());
    });
  }

  List<CarModel> myCars = [];
  getMyCars() {
    emit(AppGetMyCarsLoadingState());
    DioHelper.getData(path: "user/${CacheHelper.getData(key: "id")}/cars/")
        .then((value) {
      value?.data.forEach((e) {
        myCars.add(CarModel.fromJson(e));
      });
      emit(AppGetMyCarsSuccessState());
    }).catchError((error) {
      emit(AppGetMyCarsErrorState());
    });
  }

  List<CarModel> userCar = [];
  getUserCar({required String id}) {
    emit(AppGetUserCarLoadingState());
    DioHelper.getData(path: "user/$id/cars/").then((value) {
      value?.data.forEach((e) {
        userCar.add(CarModel.fromJson(e));
      });
      emit(AppGetUserCarSuccessState());
    }).catchError((error) {
      emit(AppGetUserCarErrorState());
    });
  }

  addCar(
      {required String manfuctrer,
      required String condition,
      required String type,
      required String feul,
      required String transmission,
      required String mileAge,
      required String color,
      required String year,
      String? description,
      required String price,
      required String model,
      required XFile image}) async {
    emit(AppAddCarCarLoadingState());
    DioHelper.postData(
        path: "car/car-list/",
        headers: {
          "Authorization": CacheHelper.getData(key: "token"),
        },
        data: FormData.fromMap(
          {
            "manufacturer": manfuctrer,
            "condition": condition,
            "fuel": feul,
            "mileage": mileAge,
            "transmission": transmission,
            "type": type,
            "description": description,
            "color": color,
            "year": year,
            "price": price,
            "model": model,
            "image_url":
                await MultipartFile.fromFile(image.path, filename: image.name),
            "owner": "${CacheHelper.getData(key: "id")}"
          },
        )).then((value) {
      print(value?.data);
      getMyCars();
      getCars();
      emit(AppAddCarCarSuccessState());
    }).catchError((error) {
      print(error.toString());
      print(error.response.data);
      emit(AppAddCarCarErrorState());
    });
  }

  String? price;
  getPrice(
      {required String manfuctrer,
      required String condition,
      required String type,
      required String feul,
      required String transmission,
      required String mileAge,
      required String year}) {
    emit(AppGetPriceCarLoadingState());
    DioHelper.postData(path: "ai-model/prediction/", data: {
      "manufacturer": manfuctrer,
      "condition": condition,
      "fuel": feul,
      "mileage": mileAge,
      "transmission": transmission,
      "type": type,
      "year": year
    }).then((value) {
      price = value?.data;
      emit(AppGetPriceCarSuccessState());
    }).catchError((error) {
      emit(AppGetPriceCarErrorState());
    });
  }

  List<CarModel> carSearch = [];

  searchCar({
    String? manufacturer,
    String? model,
    String? minPrice,
    String? maxPrice,
    String? minMileage,
    String? maxMileage,
  }) {
    emit(AppSearchCarLoadingState());
    DioHelper.getData(path: "car/car-list", queryParameters: {
      "manufacturer": manufacturer,
      "model": model,
      "min_price": minPrice,
      "max_price": maxPrice,
      "min_mileage": minMileage,
      "max_mileage": maxMileage
    }).then((value) {
      value?.data.forEach((e) {
        carSearch.add(CarModel.fromJson(e));
      });
      emit(AppSearchCarSuccessState());
    }).catchError((error) {
      emit(AppSearchCarErrorState());
    });
  }

  //================================================================================================
  List<String> categories = [];
  getCategories() {
    emit(AppGetCategoriesLoadingState());
    DioHelper.getData(path: "carpart/categories/").then((value) {
      value?.data.forEach((e) {
        categories.add(e);
      });
      emit(AppGetCategoriesSuccessState());
    }).catchError((error) {
      emit(AppGetCategoriesErrorState());
    });
  }

  List<CarPartModel> categoryDetails = [];
  getCategoryDetail({required String category}) {
    categoryDetails = [];
    emit(AppGetCategoryDetailLoadingState());
    DioHelper.getData(
        path: "carpart/part",
        queryParameters: {"category": category}).then((value) {
      print(value?.data);
      value?.data["startswith_matches"].forEach((e) {
        categoryDetails.add(CarPartModel.fromJson(e));
      });
      emit(AppGetCategoryDetailSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetCategoryDetailErrorState());
    });
  }

  List<CarPartModel> exactMatches = [];
  List<CarPartModel> startwithMatches = [];
  List<CarPartModel> suggestedMatches = [];
  searchCarPart({
    String? name,
    String? minPrice,
    String? maxPrice,
  }) {
    emit(AppSearchCarPartLoadingState());
    DioHelper.getData(path: "carpart/part", queryParameters: {
      "name": name,
      "price_range_min": minPrice,
      "max_range_max": maxPrice
    }).then((value) {
      value?.data["startswith_matches"].forEach((e) {
        startwithMatches.add(CarPartModel.fromJson(e));
      });
      value?.data["exact_matches"].forEach((e) {
        exactMatches.add(CarPartModel.fromJson(e));
      });
      value?.data["suggested_matches"].forEach((e) {
        suggestedMatches.add(CarPartModel.fromJson(e));
      });
      emit(AppSearchCarPartSuccessState());
    }).catchError((error) {
      emit(AppSearchCarPartLoadingState());
    });
  }
}
