import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_of_beauty/features/authentication/data/models/main_response.dart';
import 'package:touch_of_beauty/features/user/data/models/paginate_model.dart';
import 'package:touch_of_beauty/features/user/data/repository/services_providers_repository.dart';
import '../../data/models/services_providers_model.dart';
import '../../data/models/slider_model.dart';
import 'services_providers_state.dart';

class ServicesProvidersCubit extends Cubit<ServicesProvidersState> {
  ServicesProvidersCubit() : super(ServicesProvidersInitial());

  static ServicesProvidersCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  late MainResponse mainResponse;
  ServicesProviderModel? servicesProviderModel;
  PaginateModel? servicesProviderPaginateModel;
  PaginateModel? featuredServicesProviderPaginateModel;
  Map<dynamic , bool> favorites = {} ;
  int servicesProviderPageNumber = 1;
  int featuredServicesProviderPageNumber = 1;
  List<SliderModel> sliderPhotosList =[];
  List<ServicesProviderModel> servicesProvidersList =[];
  List<ServicesProviderModel> featuredServicesProvidersList =[];
  bool getSliderPhotosLoading = false;
   void getFeaturedServicesProviders() async{
     if(featuredServicesProviderPageNumber == 1){
       featuredServicesProvidersList = [];
       emit(GetFeaturedServicesProvidersLoadingState());
     }
     try{
       final response = await ServicesProvidersRepository.getAllFeaturedServicesProviders(pageNumber: featuredServicesProviderPageNumber);
       mainResponse = MainResponse.fromJson(response.data);
       if (mainResponse.errorCode == 0) {
         featuredServicesProviderPaginateModel =
             PaginateModel.fromJson(mainResponse.data);
         if (featuredServicesProviderPageNumber == 1) {
           for (var element in featuredServicesProviderPaginateModel!.items) {
             featuredServicesProvidersList.add(ServicesProviderModel.fromJson(element));
             if(!favorites.containsKey(element['id'])){
               favorites.addAll({element['id']: element['isFavourite']});
             }
           }
           featuredServicesProviderPageNumber++;
         } else if (featuredServicesProviderPageNumber <=
             featuredServicesProviderPaginateModel!.totalPages!) {
           for (var element in featuredServicesProviderPaginateModel!.items) {
             featuredServicesProvidersList.add(ServicesProviderModel.fromJson(element));
             if(!favorites.containsKey(element['id'])){
               favorites.addAll({element['id']: element['isFavourite']});
             }
           }
           featuredServicesProviderPageNumber++;
         }
       }
       emit(GetFeaturedServicesProvidersSuccess());
     }catch(error){
       emit(GetFeaturedServicesProvidersError(error: error.toString()));
     }


   }

   void getAllServicesProviders() async{
     if(servicesProviderPageNumber == 1){
       servicesProvidersList = [];
       emit(GetAllServicesProvidersLoadingState());
     }
     try{
       final response = await ServicesProvidersRepository.getAllServicesProviders(pageNumber: servicesProviderPageNumber);
       mainResponse = MainResponse.fromJson(response.data);
       if (mainResponse.errorCode == 0) {
         servicesProviderPaginateModel =
             PaginateModel.fromJson(mainResponse.data);
         if (servicesProviderPageNumber == 1) {
           for (var element in servicesProviderPaginateModel!.items) {
             servicesProvidersList.add(ServicesProviderModel.fromJson(element));
             if(!favorites.containsKey(element['id'])){
               favorites.addAll({element['id']: element['isFavourite']});
             }
           }
           servicesProviderPageNumber++;
         } else if (servicesProviderPageNumber <=
             servicesProviderPaginateModel!.totalPages!) {
           for (var element in servicesProviderPaginateModel!.items) {
             servicesProvidersList.add(ServicesProviderModel.fromJson(element));
             if(!favorites.containsKey(element['id'])){
               favorites.addAll({element['id']: element['isFavourite']});
             }
           }
           servicesProviderPageNumber++;
         }
       }
       emit(GetAllServicesProvidersSuccess());
     }catch(error){
       emit(GetAllServicesProvidersError(error: error.toString()));
     }

   }

   void getServicesProviderDataByItsId({required String id}) async{
     servicesProviderModel = null;
     emit(GetServicesProviderDetailsByItsIdLoadingState());
     try{
       final response = await ServicesProvidersRepository.getServicesProviderById(id: id);
       mainResponse = MainResponse.fromJson(response.data);
       servicesProviderModel = ServicesProviderModel.fromJson(mainResponse.data);
       emit(GetServicesProviderDetailsByItsIdSuccess());
     }catch(error){
       emit(GetServicesProviderDetailsByItsIdError(error: error.toString()));
     }

   }

   void addServicesProviderToFavorite({required String id})async{
     favorites[id] = !favorites[id]!;
     emit(AddServicesProviderToFavLoading());
     final response = await ServicesProvidersRepository.addServicesProviderToFavorite(id: id);
     mainResponse = MainResponse.fromJson(response.data);
     if(mainResponse.errorCode == 0){
       emit(AddServicesProviderToFavSuccess());
     }else{
       emit(AddServicesProviderToFavError(error: mainResponse.errorMessage.toString()));
     }
   }

   void deleteServicesProviderToFavorite({required String id})async{
     favorites[id] = !favorites[id]!;
     emit(DeleteServicesProviderToFavLoading());
     final response = await ServicesProvidersRepository.deleteServicesProviderFromFavorite(id: id);
     mainResponse = MainResponse.fromJson(response.data);
     if(mainResponse.errorCode == 0){
       emit(DeleteServicesProviderToFavSuccess());
     }else{
       emit(DeleteServicesProviderToFavError(error: mainResponse.errorMessage.toString()));
     }
   }

  void getSliderPhotos() async{
    getSliderPhotosLoading = true;
    emit(GetSliderPhotosLoading());
    try{
      final response = await ServicesProvidersRepository.getSliderPhotos();
      mainResponse = MainResponse.fromJson(response.data);
      for(var element in mainResponse.data){
        sliderPhotosList.add(SliderModel.fromJson(element));
      }
      getSliderPhotosLoading = false;
      emit(GetSliderPhotosSuccess());
    }catch(error){
      emit(GetSliderPhotosError(error: error.toString()));
    }

  }


}