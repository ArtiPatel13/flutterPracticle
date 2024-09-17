

import 'package:flutter_practicle/model/details_model.dart';

import '../../model/listing_model.dart';

abstract class DashboardStates{}

class DashboardInitialState extends DashboardStates{}

class DashboardLoadingState extends DashboardStates{}

class DashboardErrorState extends DashboardStates{
  final String error;
  DashboardErrorState({required this.error});
}

class DashboardNetworkErrorState extends DashboardStates{
  final String error;
  DashboardNetworkErrorState({required this.error});
}

class DashboardResponseErrorState extends DashboardStates{}

class DashboardSuccessState extends DashboardStates{
  ListingModel? model;
  DashboardSuccessState({this.model});
}
class DashboardSearchSuccessState extends DashboardStates{
  ListingModel? model;
  DashboardSearchSuccessState({this.model});
}
class DashboardDetailsSuccessState extends DashboardStates{
  DetailsModel? model;
  DashboardDetailsSuccessState({this.model});
}
class FilterSuccessState extends DashboardStates{
  ListingModel? model;
  FilterSuccessState({this.model});
}
