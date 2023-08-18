import 'dart:async';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/remote/api/http_manager.dart';
import 'package:heidi/src/utils/asset.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class Api {
  static final httpManager = HTTPManager();

  static const String login = "/users/login";
  static const String user = "/users/";
  static const String register = "/users/register";
  static const String forgotPassword = "/users/forgotPassword";
  static const String changePassword = "/users/resetPassword";
  static const String categories = "/categories";
  static const String categoriesCount = "/categories/listingsCount";
  static const String list = "listings";
  static const String uploadImage = "/users/4/imageUpload";
  static const String cities = "/cities";
  static const String listings = "/listings?statusId=1";
  static const String contact = "/contactUs";

  static Future<ResultApiModel> requestLogin(params) async {
    try {
      final result = await httpManager.post(url: login, data: params);
      return ResultApiModel.fromJson(result);
    } catch (e) {
      return await httpManager.post(url: login, data: params);
    }
  }

  static Future<ResultApiModel> requestEditProduct(
      cityId, listingId, params, bool isImageChanged) async {
    final filePath = '/cities/$cityId/listings/$listingId';
    final result = await httpManager.patch(
      url: filePath,
      data: params,
      loading: true,
    );
    if (isImageChanged) {
      await Api.requestListingUploadImage(listingId, cityId);
    }
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestFavorites(userId) async {
    final result = await httpManager.get(url: '/users/$userId/favorites/');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestFavoritesDetailsList(
      cityId, listingId) async {
    final result =
        await httpManager.get(url: '/cities/$cityId/listings/$listingId');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestForgotPassword(params) async {
    Map<String, dynamic> result = await httpManager.post(
      url: forgotPassword,
      data: params,
      loading: true,
    );
    result['message'] = result['status'] ?? result['msg'];
    return ResultApiModel.fromJson(result);
  }

  ///Register account
  static Future<ResultApiModel> requestRegister(params) async {
    final result = await httpManager.post(
      url: register,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUserListings(userId) async {
    final result = await httpManager.get(url: '/users/$userId/listings/');
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> deleteUserList(cityId, int listingId) async {
    final String removeList = "/cities/$cityId/listings/$listingId";
    final result = await httpManager.delete(
      url: removeList,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Change Profile
  static Future<ResultApiModel> requestChangeProfile(params, userId) async {
    final filePath = '/users/$userId';
    final result = await httpManager.patch(
      url: filePath,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///change password
  static Future<ResultApiModel> requestChangePassword(params) async {
    final result = await httpManager.post(
      url: changePassword,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUser({required userId}) async {
    final filePath = '/users/$userId';
    final result = await httpManager.get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  ///Get Category
  static Future<ResultApiModel> requestCategory(params) async {
    final result = await UtilAsset.loadJson("assets/data/category.json");
    // final result = await httpManager.get(url: categories, params: params);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSubmitCategory() async {
    final result = await httpManager.get(url: categories);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSubmitSubCategory(
      {required categoryId}) async {
    final filePath = '/categories/$categoryId/subcategories';
    final result = await httpManager.get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestCategoryCount(int? cityId) async {
    String url = categoriesCount;
    if (cityId != null) {
      url = "$url?cityId=$cityId";
    }
    final result = await httpManager.get(url: url);
    return ResultApiModel.fromJson(result);
  }

  ///Get Home Categories
  static Future<ResultApiModel> requestHomeCategory() async {
    final result = await UtilAsset.loadJson("assets/data/category.json");
    // final result = await httpManager.get(url: categories);
    return ResultApiModel.fromJson(result);
  }

  ///Get Cities
  static Future<ResultApiModel> requestCities() async {
    // final result = await UtilAsset.loadJson("assets/data/locations.json");
    final result = await httpManager.get(url: cities);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestVillages({required cityId}) async {
    final filePath = '/cities/$cityId/villages';
    final result = await httpManager.get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  ///Get Submit Cities
  static Future<ResultApiModel> requestSubmitCities() async {
    final result = await httpManager.get(url: cities);
    return ResultApiModel.fromJson(result);
  }

  ///Get Recent Listings
  static Future<ResultApiModel> requestRecentListings(params) async {
    final listings = "/listings?statusId=1&pageNo=$params&pageSize=19";
    final result = await httpManager.get(url: listings);
    return ResultApiModel.fromJson(result);
  }

  ///Get Home Slider Images
  static Future<ResultApiModel> requestSliderImages() async {
    final result = await UtilAsset.loadJson("assets/data/sliders.json");
    return ResultApiModel.fromJson(result);
  }

  ///Get ProductDetail
  static Future<ResultApiModel> requestProduct(cityId, id) async {
    final filePath = '/cities/$cityId/listings/$id';
    final result = await httpManager.get(url: filePath);
    return ResultApiModel.fromJson(result);
  }

  ///Save Wish List
  static Future<ResultApiModel> requestAddWishList(userId, params) async {
    final String addWishList = "/users/$userId/favorites/";
    final result = await httpManager.post(url: addWishList, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Save Product
  static Future<ResultApiModel> requestSaveProduct(cityId, params) async {
    final filePath = '/cities/$cityId/listings';
    final result = await httpManager.post(
      url: filePath,
      data: params,
      loading: true,
    );
    final id = result['id'];
    Api.requestListingUploadImage(id, cityId);
    return ResultApiModel.fromJson(result);
  }

  ///Remove Wish List
  static Future<ResultApiModel> requestRemoveWishList(
      userId, int listingId) async {
    final String removeWishList = "/users/$userId/favorites/$listingId";
    final result = await httpManager.delete(
      url: removeWishList,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<ResultApiModel> requestCatList(params, pageNo) async {
    var list =
        '/listings?categoryId=$params&statusId=1&pageNo=$pageNo&pageSize=19';
    final result = await httpManager.get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestSubCatList(params, pageNo) async {
    var list =
        '/listings?subCategoryId=10&categoryId=1&statusId=1&pageNo=$pageNo&pageSize=19';
    final result = await httpManager.get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestLocList(params, pageNo) async {
    var list = '/listings?cityId=$params&statusId=1&pageNo=$pageNo&pageSize=19';
    final result = await httpManager.get(url: list);
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> contactUs(params) async {
    final result = await httpManager.post(
      url: contact,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  static Future<ResultApiModel> requestUploadImage(formData) async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, '');
    var filepath = '/users/$userId/imageUpload';
    var result = await httpManager.post(
      url: filepath,
      formData: formData,
    );

    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  static Future<ResultApiModel> requestListingUploadImage(
      listingId, cityId) async {
    final prefs = await Preferences.openBox();
    final pickedFile = prefs.getPickedFile();
    logError('pickedFile', pickedFile);
    var filepath = '/cities/$cityId/listings/$listingId/imageUpload';
    var result = await httpManager.post(
      url: filepath,
      formData: pickedFile,
    );
    logError('resultImage', result);
    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
