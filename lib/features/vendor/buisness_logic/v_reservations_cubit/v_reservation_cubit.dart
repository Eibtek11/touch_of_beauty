import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_of_beauty/features/authentication/data/models/main_response.dart';

import '../../../authentication/data/repository/auth_repository.dart';
import '../../../user/data/models/notification_model.dart';
import '../../data/models/reserve_model.dart';
import '../../data/repository/services_repo.dart';

import 'v_reservation_state.dart';

class VReservationCubit extends Cubit<VReservationState> {
  VReservationCubit() : super(VReservationInitial());
  static VReservationCubit get(context) => BlocProvider.of(context);

  late MainResponse mainResponse;
  ReserveModel? reserveModel;
  String message ='';

  List<ReserveModel> getPreparedOrdersList =[];
  List<ReserveModel> getConfirmedOrdersList =[];
  List<ReserveModel> getTodayOrdersList =[];
  List<ReserveModel> getWithDriverOrdersList =[];
  List<ReserveModel> getFinishedOrdersList =[];
  List<ReserveModel> getCanceledOrdersList =[];
  List<NotificationModel> notificationList =[];

  void getPreparedOrders()async{
    try{
      emit(GetPreparedOrdersLoading());
      final response = await VendorServicesRepository.getPreparedOrders();
      mainResponse = MainResponse.fromJson(response.data);
      if(mainResponse.errorCode == 0){
        for(var element in mainResponse.data){
          if(!getPreparedOrdersList.contains(ReserveModel.fromJson(element))){
            getPreparedOrdersList.add(ReserveModel.fromJson(element));
          }
        }
      }

      else{
        message = mainResponse.errorMessage;
      }
      print(response);
      emit(GetPreparedOrdersSuccess());
    }catch(error){
      emit(GetPreparedOrdersError(error: error.toString()));
    }
  }
  void getConfirmedOrders()async{
    try{
      emit(GetConfirmedOrdersLoading());
      final response = await VendorServicesRepository.getConfirmedOrders();
      mainResponse = MainResponse.fromJson(response.data);
      if(mainResponse.errorCode == 0){
        for(var element in mainResponse.data){
          if(!getConfirmedOrdersList.contains(ReserveModel.fromJson(element))){
            getConfirmedOrdersList.add(ReserveModel.fromJson(element));
          }
        }
      }
      else{
        message = mainResponse.errorMessage;
      }
      emit(GetConfirmedOrdersSuccess());
    }catch(error){
      emit(GetConfirmedOrdersError(error: error.toString()));
    }
  }

  String startDate = DateTime.now().subtract(const Duration(days: 1)).toString();
  String endDate = DateTime.now().add(const Duration(days: 1)).toString();
  void getTodayOrders({required bool inHome,})async{
    try{
      emit(GetTodayOrdersLoading());
      final response = await VendorServicesRepository.getTodayOrders(inHome: inHome, startDate: startDate, endDate: endDate);
      mainResponse = MainResponse.fromJson(response.data);
      getTodayOrdersList.clear();
      if(mainResponse.errorCode == 0){
        for(var element in mainResponse.data){
            getTodayOrdersList.add(ReserveModel.fromJson(element));
        }
      }
      else{
        message = mainResponse.errorMessage;
      }
      print(response);
      emit(GetTodayOrdersSuccess());
    }catch(error){
      emit(GetTodayOrdersError(error: error.toString()));
    }
  }
  void getWithDriverOrders()async{
    try{
      emit(GetWithDriverOrdersLoading());
      final response = await VendorServicesRepository.getWithDriverOrders();
      mainResponse = MainResponse.fromJson(response.data);
      if(mainResponse.errorCode == 0){
        for(var element in mainResponse.data){
          if(!getWithDriverOrdersList.contains(ReserveModel.fromJson(element))){
            getWithDriverOrdersList.add(ReserveModel.fromJson(element));
          }
        }
      }
      else{
        message = mainResponse.errorMessage;
      }
      emit(GetWithDriverOrdersSuccess());
    }catch(error){
      emit(GetWithDriverOrdersError(error: error.toString()));
    }
  }
  void getFinishedOrders()async{
    try{
      emit(GetFinishedOrdersLoading());
      final response = await VendorServicesRepository.getFinishedOrders();
      mainResponse = MainResponse.fromJson(response.data);
      if(mainResponse.errorCode == 0){
        for(var element in mainResponse.data){
          if(!getFinishedOrdersList.contains(ReserveModel.fromJson(element))){
            getFinishedOrdersList.add(ReserveModel.fromJson(element));
          }
        }
      }
      else{
        message = mainResponse.errorMessage;
      }
      emit(GetFinishedOrdersSuccess());
    }catch(error){
      emit(GetFinishedOrdersError(error: error.toString()));
    }
  }

  void getCanceledOrders()async{
    try{
      emit(GetCanceledOrdersLoading());
      final response = await VendorServicesRepository.getCanceledOrders();
      mainResponse = MainResponse.fromJson(response.data);
      if(mainResponse.errorCode == 0){
        for(var element in mainResponse.data){
          if(!getCanceledOrdersList.contains(ReserveModel.fromJson(element))){
            getCanceledOrdersList.add(ReserveModel.fromJson(element));
          }
        }
      }
      else{
        message = mainResponse.errorMessage;
      }
      emit(GetCanceledOrdersSuccess());
    }catch(error){
      emit(GetCanceledOrdersError(error: error.toString()));
    }
  }
  void getOrdersById({required int orderId})async{
    try{
      reserveModel = null;
      emit(GetOrderByItsIdLoading());
      final response = await VendorServicesRepository.getOrdersById(orderId: orderId);
      mainResponse = MainResponse.fromJson(response.data);
      if(mainResponse.errorCode == 0){
        reserveModel = ReserveModel.fromJson(mainResponse.data);
        if(reserveModel!.orderStatus! == 2){
          getPreparedOrdersList.removeWhere((element) => element.id == reserveModel!.id!);
        }else if(reserveModel!.orderStatus! == 3){
          getConfirmedOrdersList.removeWhere((element) => element.id! == reserveModel!.id);
        }else if(reserveModel!.orderStatus! == 4){
          getWithDriverOrdersList.removeWhere((element) => element.id! == reserveModel!.id);
        }
      }
      else{
        message = mainResponse.errorMessage;
      }
      emit(GetOrderByItsIdSuccess());
    }catch(error){
      emit(GetOrderByItsIdError(error: error.toString()));
    }
  }

  void changeOrderStatus({required int orderId,required int orderStatus,})async{
    try{
      emit(ChangeOrderStatusLoading());
      final response = await VendorServicesRepository.changeOrderStatus(orderId: orderId, orderStatus: orderStatus);
      mainResponse = MainResponse.fromJson(response.data);
      emit(ChangeOrderStatusSuccess());
    }catch(error){
      emit(ChangeOrderStatusError(error: error.toString()));
    }
  }

  void getAllNotifications() async{
    emit(GetNotificationLoading());
    try{
      final response = await AuthRepository.getAllNotifications();
      mainResponse = MainResponse.fromJson(response.data);
      message = mainResponse.errorMessage.toString();
      notificationList = [];
      for(var element in mainResponse.data){
        notificationList.add(NotificationModel.fromJson(element));
      }
      emit(GetNotificationSuccess());
    }catch(error){
      emit(GetNotificationError(error: error.toString()));
    }
  }


}
