import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_of_beauty/core/cache_manager/cache_keys.dart';
import 'package:touch_of_beauty/core/cache_manager/shared_preferences.dart';
import 'package:touch_of_beauty/core/constants/constants.dart';
import 'package:touch_of_beauty/features/authentication/data/repository/auth_repository.dart';
import '../../../core/network/dio_helper.dart';
import '../../vendor/data/models/pictures_model.dart';
import '../data/models/cities_model.dart';
import '../data/models/confirm_register_model.dart';
import '../data/models/get_user_data_model.dart';
import '../data/models/login_model.dart';
import '../data/models/main_response.dart';
import '../data/models/register_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  String? cityValue;
  int cityId = 1;
  List<CitiesModel> citiesList = [];
  List<String> citiesNamesList = [];
  List<PicturesModel> picturesList = [];
  Map<String, dynamic> picturesMap = {};
  late MainResponse mainResponse;
  int data = 0;
  ImagePicker picker = ImagePicker();
  File? profileImage;
  File? freelancerImage;
  String? message;
  GetUserModel? getUserModel;

  void getCities() async {
    cityValue = null;
    emit(GetCitiesLoading());
    final response = await DioHelper.getData(
        url: 'http://lightbulbtech-001-site13.etempurl.com/api/Cities',
        bearerToken: token);
    citiesList.clear();
    citiesNamesList.clear();
    for (var element in response.data['data']) {
      citiesList.add(CitiesModel.fromJson(element));
    }
    for (var element in citiesList) {
      citiesNamesList.add(element.name!);
    }
    cityValue = citiesNamesList.first;
    emit(GetCitiesSuccess());
  }

  void onCityChanged(String value) {
    cityValue = value;
    for (var element in citiesList) {
      if (element.name == cityValue) {
        cityId = element.id!;
      }
    }
    emit(GetChangedCity());
  }

  Future<void> getImagePick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetPickedImageSuccessState());
    } else {
      emit(GetPickedImageErrorState());
    }
  }

  Future<void> getFreelanceImagePick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      freelancerImage = File(pickedFile.path);
      emit(GetPickedImageSuccessState());
    } else {
      emit(GetPickedImageErrorState());
    }
  }

  void login({
    required String phone,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final response =
          await AuthRepository.login(phone: phone, password: password);
      mainResponse = MainResponse.fromJson(response.data);
      message = mainResponse.errorMessage.toString();
      if (mainResponse.errorCode == 0) {
        print(response);
        emit(LoginSuccess(loginModel: LoginModel.fromJson(mainResponse.data)));
      } else {
        emit(LoginSuccessButErrorInData(errorMessage: message!));
      }
    } catch (error) {
      emit(LoginError(error: error.toString()));
    }
  }

  void logout() async {
    emit(LogoutLoading());
    try {
      await AuthRepository.logout();
      token = null;
      userType = null;
      profileImage = null;
      freelancerImage = null;
      message = null;
      getUserModel = null;
      await CacheHelper.removeData(key: CacheKeys.token);
      await CacheHelper.removeData(key: CacheKeys.userType);
      emit(LogoutSuccess());
    } catch (error) {
      emit(LogoutError(error.toString()));
    }
  }

  void userRegister({
    required String userName,
    required String password,
    required String email,
    required String phone,
  }) async {
    emit(RegisterLoading());
    try {
      final response = await AuthRepository.userRegister(
        userName: userName,
        password: password,
        email: email,
        phone: phone,
        cityId: cityId,
        image: profileImage,
      );
      mainResponse = MainResponse.fromJson(response.data);
      message = mainResponse.errorMessage.toString();
      profileImage = null;
      emit(RegisterSuccess(RegisterModel.fromJson(mainResponse.data)));
    } catch (error) {
      emit(RegisterError(error.toString()));
    }
  }

  void vendorRegister({
    required String userName,
    required String password,
    required String email,
    required String description,
    required String phone,
    required String taxNumber,
  }) async {
    emit(RegisterLoading());
    try {
      final response = await AuthRepository.vendorRegister(
        userName: userName,
        password: password,
        email: email,
        description: description,
        phone: phone,
        cityId: cityId,
        image: profileImage,
        taxNumber: taxNumber,
      );
      mainResponse = MainResponse.fromJson(response.data);
      message = mainResponse.errorMessage.toString();
      profileImage = null;
      emit(RegisterSuccess(RegisterModel.fromJson(mainResponse.data)));
    } catch (error) {
      emit(RegisterError(error.toString()));
    }
  }

  void freelancerRegister({
    required String userName,
    required String password,
    required String email,
    required String description,
    required String phone,
  }) async {
    emit(RegisterLoading());
    try {
      final response = await AuthRepository.freelancerRegister(
        userName: userName,
        password: password,
        email: email,
        description: description,
        phone: phone,
        cityId: cityId,
        freelancerImage: freelancerImage,
        image: profileImage,
      );
      mainResponse = MainResponse.fromJson(response.data);
      message = mainResponse.errorMessage.toString();
      profileImage = null;
      emit(RegisterSuccess(RegisterModel.fromJson(mainResponse.data)));
    } catch (error) {
      emit(RegisterError(error.toString()));
    }
  }

  void confirmRegister({
    required String phone,
    required String randomCode,
  }) async {
    emit(ConfirmRegisterLoading());
    try {
      final response = await AuthRepository.confirmRegister(
        phone: phone,
        randomCode: randomCode,
      );
      mainResponse = MainResponse.fromJson(response.data);
      message = mainResponse.errorMessage.toString();
      emit(ConfirmRegisterSuccess(
          ConfirmRegisterModel.fromJson(mainResponse.data)));
    } catch (error) {
      emit(ConfirmRegisterError(error.toString()));
    }
  }

  void confirmPassword({
    required String phone,
    required String randomCode,
  }) async {
    emit(ConfirmForgetPasswordLoading());
    try {
      final response = await AuthRepository.confirmForgetPassword(
        phone: phone,
        randomCode: randomCode,
      );
      mainResponse = MainResponse.fromJson(response.data);
      message = mainResponse.errorMessage.toString();
      emit(
          ConfirmForgetPasswordSuccess(LoginModel.fromJson(mainResponse.data)));
    } catch (error) {
      emit(ConfirmForgetPasswordError(error.toString()));
    }
  }

  void getUserData() async {
    emit(GetUserDataLoading());
    try {
      final response = await AuthRepository.getUserData();
      mainResponse = MainResponse.fromJson(response.data);
      message = mainResponse.errorMessage.toString();
      getUserModel = GetUserModel.fromJson(mainResponse.data);
      if (picturesList.isEmpty && data == 0) {
        getAllPicturesForProvider();
        getAllPicturesForProvider();
      }
      emit(GetUserDataSuccess());
    } catch (error) {
      emit(GetUserDataError(error.toString()));
    }
  }

  void getAllPicturesForProvider() async {
    emit(GetPicturesForProviderLoading());
    try {
      final response = await AuthRepository.getAllPicturesForProvider();
      mainResponse = MainResponse.fromJson(response.data);
      if (mainResponse.errorCode == 0) {
        for (var element in mainResponse.data) {
          print(picturesList.contains(PicturesModel.fromJson(element)));
          if(!picturesList.contains(PicturesModel.fromJson(element))){
            picturesList.add(PicturesModel.fromJson(element));
          }
        }
      } else {
        data = mainResponse.errorCode;
      }
      picturesList.length;
      emit(GetPicturesForProviderSuccess());
    } catch (error) {
      emit(GetPicturesForProviderError(error.toString()));
    }
  }

  void addPictureToLibrary() async {
    emit(AddPictureLoading());
    try {
      final response =
          await AuthRepository.addPictureToLibrary(image: profileImage);
      mainResponse = MainResponse.fromJson(response.data);
      print(response);
      if (mainResponse.errorCode == 0) {
        profileImage = null;
        getAllPicturesForProvider();
      }
      emit(AddPictureSuccess());
    } catch (error) {
      emit(AddPictureError(error.toString()));
    }
  }

  void deletePictureToLibrary({required int id}) async {
    emit(DeletePictureLoading());
    try {
      final response =
          await AuthRepository.deleteImage(id: id);
      mainResponse = MainResponse.fromJson(response.data);
      if(mainResponse.errorCode == 0){
        picturesList.removeWhere((element) => element.id! == id);
      }
      emit(DeletePictureSuccess());
    } catch (error) {
      emit(DeletePictureError(error.toString()));
    }
  }

  void vendorUpdateProfile({
    required String userName,
    required String email,
    required String description,
    required String phone,
    required String taxNumber,
  }) async {
    emit(UpdateProfileLoading());
    try {
      await AuthRepository.vendorUpdateProfile(
          userName: userName,
          email: email,
          description: description,
          phone: phone,
          taxNumber: taxNumber,
          image: profileImage);
      profileImage = null;
      emit(UpdateProfileSuccess());
    } catch (error) {
      print(error.toString());
      emit(UpdateProfileError(error.toString()));
    }
  }

  void userUpdateProfile({
    required int cityId,
    required String email,
    required String name,
    required String phoneNumber,
    required File? image,
  }) async {
    emit(UpdateProfileLoading());
    try {
      await AuthRepository.userUpdateProfile(
          cityId: cityId,
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          image: profileImage);
      profileImage = null;
      emit(UpdateProfileSuccess());
    } catch (error) {
      emit(UpdateProfileError(error.toString()));
    }
  }

  void forgetPassword({
    required String phoneNumber,
  }) async {
    emit(ForgetPasswordLoading());
    try {
      final response = await AuthRepository.forgetPassword(
        phone: phoneNumber,
      );
      mainResponse = MainResponse.fromJson(response.data);
      emit(ForgetPasswordSuccess(mainResponse: mainResponse));
    } catch (error) {
      emit(ForgetPasswordError(error.toString()));
    }
  }
}
