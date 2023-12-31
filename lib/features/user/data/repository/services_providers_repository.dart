import 'package:dio/dio.dart';
import 'package:touch_of_beauty/core/network/api_end_points.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/network/dio_helper.dart';

class ServicesProvidersRepository {
  static Future<Response> getAllServicesProviders(
      {required int pageNumber}) async {
    final response = await DioHelper.getData(
      url: EndPoints.getAllServicesProviders,
      bearerToken: token,
      query: {'PageNumber': pageNumber, 'PageSize': 15},
    );
    return response;
  }

  static Future<Response> getMainSections() async {
    final response = await DioHelper.getData(
        url: EndPoints.getMainSections, bearerToken: token);
    return response;
  }

  static Future<Response> getAllFeaturedServicesProviders(
      {required int pageNumber}) async {
    final response = await DioHelper.getData(
        url: EndPoints.getAllFeaturedServicesProviders,
        query: {'PageNumber': pageNumber, 'PageSize': 10},
        bearerToken: token);
    return response;
  }

  static Future<Response> getServicesInHomeOrInCenter({
    required bool inHome,
  }) async {
    final response = await DioHelper.getData(
        url: EndPoints.getServicesInHomeOrInCenter(inHome: inHome),
        query: {'PageNumber': 1, 'PageSize': 10},
        bearerToken: token);
    return response;
  }

  static Future<Response> getServicesByServiceProviderId({
    required int pageNumber,
  }) async {
    final response = await DioHelper.getData(
        url: EndPoints.getServicesForServicesProvider,
        query: {'PageNumber': pageNumber, 'PageSize': 30},
        bearerToken: token);
    return response;
  }

  static Future<Response> getSliderPhotos() async {
    final response =
        await DioHelper.getData(url: EndPoints.slidePhotos, bearerToken: token);
    return response;
  }

  static Future<Response> getServicesProviderById({
    required String id,
  }) async {
    final response = await DioHelper.getData(
      url: "${EndPoints.getServicesProviderById}$id",
      bearerToken: token,
    );
    return response;
  }

  static Future<Response> getFeaturedMainSections() async {
    final response = await DioHelper.getData(
        url: EndPoints.getFeaturedMainSections, bearerToken: token);
    return response;
  }

  static Future<Response> getServicesByMainFeatureId({required int id}) async {
    final response = await DioHelper.getData(
        url: "${EndPoints.getServicesByMainFeatureId}$id", bearerToken: token);
    return response;
  }

  static Future<Response> getFavoriteServiceProviders() async {
    final response = await DioHelper.getData(
        url: EndPoints.getFavoriteProviders, bearerToken: token);
    return response;
  }

  static Future<Response> getFavoriteService() async {
    final response = await DioHelper.getData(
        url: EndPoints.getFavoriteServices, bearerToken: token);
    return response;
  }

  static Future<Response> getAllQuestions() async {
    final response = await DioHelper.getData(
      url: EndPoints.getQuestions,
    );
    return response;
  }

  static Future<Response> getServices({
    int? pageNumber,
    int? pageSize,
    int? cityId,
    int? mainSectionId,
    int? serviceTypeDto,
    int? maxPrice,
    int? minPrice,
    String? servicesProviderName,
    String? servicesProviderId,
    String? searchName,
    bool? inHome,
    bool? inCenter,
    bool? orderFromNew,
  }) async {
    final response = await DioHelper.getData(
        url: EndPoints.getServicesForUser,
        bearerToken: token,
        query: {
          'PageNumber': pageNumber,
          'PageSize': pageSize,
          'ServiceProviderName': servicesProviderName,
          'ServiceProviderId': servicesProviderId,
          'SearchName': searchName,
          'CityId': cityId,
          'MainSectionId': mainSectionId,
          'InHome': inHome,
          'InCenter': inCenter,
          'ServiceTypeDto': serviceTypeDto,
          'OrderFromNew': orderFromNew,
          'StartPrice': minPrice,
          'EndPrice': maxPrice,
        });
    return response;
  }

  static Future<Response> addServicesProviderToFavorite(
      {required String id}) async {
    final response = await DioHelper.postData(
      url: "${EndPoints.addProviderToFavorite}$id",
      token: token,
    );
    return response;
  }

  static Future<Response> deleteServicesProviderFromFavorite(
      {required String id}) async {
    final response = await DioHelper.deleteData(
      url: "${EndPoints.deleteProviderFromFavorite}$id",
      token: token,
    );
    return response;
  }

  static Future<Response> addServiceToFavorite({required int id}) async {
    final response = await DioHelper.postData(
      url: "${EndPoints.addServiceToFavorite}$id",
      token: token,
    );
    return response;
  }

  static Future<Response> deleteServiceFromFavorite({required int id}) async {
    final response = await DioHelper.deleteData(
      url: "${EndPoints.deleteServiceFromFavorite}$id",
      token: token,
    );
    return response;
  }

  static Future<Response> deleteAddress({required int id}) async {
    final response = await DioHelper.deleteData(
      url: "${EndPoints.addresses}/$id",
      token: token,
    );
    return response;
  }

  static Future<Response> addAddress({
    required int cityId,
    required String? region,
    required String? street,
    required String? buildingNumber,
    required String? flatNumber,
    required String? addressDetails,
  }) async {
    final response =
        await DioHelper.postData(url: EndPoints.addresses, token: token, data: {
      "region": region,
      "street": street,
      "buildingNumber": "مبني رقم $buildingNumber",
      "flatNumber": "شقة رقم $flatNumber",
      "addressDetails": addressDetails ?? "",
      "cityId": cityId
    });
    return response;
  }

  static Future<Response> updateAddress({
    required int cityId,
    required int addressId,
    required String? region,
    required String? street,
    required String? buildingNumber,
    required String? flatNumber,
    required String? addressDetails,
  }) async {
    final response =
        await DioHelper.putData(url: EndPoints.addresses, token: token, data: {
      "id": addressId,
      "region": region,
      "street": street,
      "buildingNumber": "مبني رقم $buildingNumber",
      "flatNumber": "شقة رقم $flatNumber",
      "addressDetails": addressDetails ?? "",
      "cityId": cityId
    });
    return response;
  }

  static Future<Response> addOrder({
    required int serviceId,
    required int addressId,
    required String dateTime,
    required bool inHome,
  }) async {
    final response =
        await DioHelper.postData(url: EndPoints.addOrder, token: token, data: {
      "startingOn": dateTime,
      "serviceId": serviceId,
      "addressId": addressId,
      "inHome": inHome
    });
    return response;
  }

  static Future<Response> addServiceRating({
    required int rating,
    required int serviceId,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.addServiceEvaluations,
      token: token,
      data: {
        "numberOfStars": rating,
        "comment": "string",
        "serviceId": serviceId
      },
    );
    return response;
  }

  static Future<Response> addServiceProviderRating({
    required int rating,
    required String serviceProviderId,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.addServiceProviderEvaluations,
      token: token,
      data: {
        "numberOfStars": rating,
        "comment": "string",
        "providerId": serviceProviderId
      },
    );
    return response;
  }

  static Future<Response> getAddress() async {
    final response =
        await DioHelper.getData(url: EndPoints.addresses, bearerToken: token);
    return response;
  }

  static Future<Response> getServicesDetailsById({
    required int id,
  }) async {
    final response = await DioHelper.getData(
      url: "${EndPoints.getServiceDetailsById}$id",
      bearerToken: token,
    );
    return response;
  }

  static Future<Response> getContactUs() async {
    final response = await DioHelper.getData(
      url: EndPoints.contactUs,
      bearerToken: token,
    );
    return response;
  }

  static Future<Response> getOrdersForUser() async {
    final response = await DioHelper.getData(
        url: EndPoints.getOrdersForUser, bearerToken: token);
    return response;
  }

  static Future<Response> confirmOrder({required int id}) async {
    final response = await DioHelper.postData(
      url: "${EndPoints.confirmOrder}$id",
      token: token,
    );
    return response;
  }

  static Future<Response> removeOrder({required int id}) async {
    final response = await DioHelper.postData(
      url: "${EndPoints.removeOrder}$id",
      token: token,
    );
    return response;
  }
}
