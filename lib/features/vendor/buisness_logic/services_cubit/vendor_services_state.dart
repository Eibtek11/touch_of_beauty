
abstract class VendorServicesState {}

class VendorServicesInitial extends VendorServicesState {}


class ChangeServicesInHomeOrInCenter extends VendorServicesState {}


class ChangeButtonState extends VendorServicesState {}


class GetPickedImageSuccessState extends VendorServicesState {}
class GetPickedImageErrorState extends VendorServicesState {}


class GetServicesInHomeOrCenterLoading extends VendorServicesState {}
class GetServicesInHomeOrCenterSuccess extends VendorServicesState {}
class GetServicesInHomeOrCenterError extends VendorServicesState {}
class GetChangedMainSectionId extends VendorServicesState {}


class GetServicesByServiceProviderIdLoading extends VendorServicesState {}
class GetServicesByServiceProviderIdSuccess extends VendorServicesState {}
class GetServicesByServiceProviderIdError extends VendorServicesState {
  final String error;

  GetServicesByServiceProviderIdError({required this.error});

}


class AddServicesLoading extends VendorServicesState {}
class AddServicesSuccess extends VendorServicesState {}
class AddServicesError extends VendorServicesState {
  final String error;

  AddServicesError({required this.error});

}


class GetMainSectionsLoadingState extends VendorServicesState {}
class GetMainSectionsSuccess extends VendorServicesState {}
class GetMainSectionsError extends VendorServicesState {
  final String error;

  GetMainSectionsError({required this.error});

}


class GetServicesDetailsByItsIdLoadingState extends VendorServicesState {}
class GetServicesDetailsByItsIdSuccess extends VendorServicesState {}
class GetServicesDetailsByItsIdError extends VendorServicesState {
  final String error;
  GetServicesDetailsByItsIdError({required this.error});
}


class DeleteServicesLoadingState extends VendorServicesState {}
class DeleteServicesSuccess extends VendorServicesState {}
class DeleteServicesError extends VendorServicesState {
  final String error;
  DeleteServicesError({required this.error});
}

class GetAddressLoading extends VendorServicesState {}
class GetAddressSuccess extends VendorServicesState {}
class GetAddressError extends VendorServicesState {
  final String error;
  GetAddressError({required this.error});
}