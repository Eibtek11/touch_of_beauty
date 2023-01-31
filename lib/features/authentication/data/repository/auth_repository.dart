import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/network/api_end_points.dart';
import '../../../../core/network/dio_helper.dart';

class AuthRepository{
  
  static Future<Response> userRegister({
    required String userName,
    required String password,
    required String email,
    required String phone,
    required int? cityId,
    required File? image,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.userRegister,
      data: {
        "fullName": userName,
        "email": email,
        "phoneNumber": phone,
        "password": password,
        "confirmPassword": password,
        "lat": 0,
        "lng": 0,
        "cityId": cityId??1,
        "img": image != null
            ? "data:image/${image.path.split('.').last};base64,${imageToBase64(image)}"
            : null
      },
    );
    return response;
  }


  static Future<Response> vendorRegister({
    required String userName,
    required String password,
    required String email,
    required String description,
    required String phone,
    required int? cityId,
    required File? image,
  }) async {

    final response = await DioHelper.postData(
      url: EndPoints.centerRegister,
      data: {
        "confirmPassword": password,
        "description": description,
        "email": email,
        "fullName": userName,
        "img": image != null?"data:image/${image.path.split('.').last};base64,${imageToBase64(image)}":null,
        "password": password,
        "phoneNumber": phone,
        "taxNumber": "<tel>",
        "lat": "21.3666",
        "lng": "21.6588",
        "cityId": cityId
      },
    );
    return response;
  }


  static Future<Response> freelancerRegister({
    required String userName,
    required String password,
    required String email,
    required String description,
    required String phone,
    required int? cityId,
    required File? freelancerImage,
    required File? image,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.freelancerRegister,
      data: {
        "fullName": userName,
        "email": email,
        "phoneNumber": phone,
        "description": description,
        "password": password,
        "confirmPassword": password,
        "lat": 0,
        "lng": 0,
        "cityId": cityId??1,
        "freelanceFormImg": freelancerImage != null
            ?  "data:image/${freelancerImage.path.split('.').last};base64,${imageToBase64(freelancerImage)}"
            : null,
        "img": image != null
            ? "data:image/${image.path.split('.').last};base64,${imageToBase64(image)}"
            : null,
      },
    );
    return response;
  }


  static Future<Response> login({
    required String phone,
    required String password,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.login,
      data: {
        "phoneNumber": phone,
        "password": password,
        "deviceToken": "string",
        "isPersist": true
      },
    );
    return response;
  }


  static Future<Response> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.changePassword,
      data: {
        "oldPassword": oldPassword,
        "newPassword": newPassword
      },
    );
    return response;
  }


  static Future<Response> forgetPassword({
    required String phone,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.forgetPassword,
      data: {
        "phoneNumber": phone
      },
    );
    return response;
  }


  static Future<Response> changeForgetPassword({
    required String phone,
    required String code,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.changeForgetPassword,
      data: {
        "phoneNumber": phone,
        "randomCode": code
      },
    );
    return response;
  }


  static Future<Response> confirmRegister({
    required String phone,
    required String randomCode,
  }) async {
    final response = await DioHelper.postData(
      url: EndPoints.confirmRegister,
      data: {
        "phoneNumber": phone,
        "randomCode": randomCode
      },
    );
    return response;
  }


  static Future<Response> getUserData() async {
    final response = await DioHelper.getData(
      url: EndPoints.getUserData,
    );
    return response;
  }
}