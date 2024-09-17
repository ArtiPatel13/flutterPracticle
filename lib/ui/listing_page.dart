import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practicle/bloc/dashboard_bloc.dart';
import 'package:flutter_practicle/constant/app_preference.dart';
import 'package:flutter_practicle/constant/font_style.dart';
import 'package:flutter_practicle/model/listing_model.dart';
import 'package:get/get.dart';

import '../bloc/events/dashboard_event.dart';
import '../bloc/states/dashboard_state.dart';
import '../constant/app_colors.dart';
import '../constant/app_loader.dart';
import '../constant/app_routes.dart';
import '../constant/custom_snackbar.dart';
import '../constant/debouncer.dart';
import '../constant_widget/edittext.dart';
import '../model/filter_model.dart';
import '../repo/login_repo.dart';

class ListingPage extends StatefulWidget {

  const ListingPage({super.key,});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  var searchController =  TextEditingController();
  FocusNode searchFocus =  FocusNode();
  final searchDebouncer = Debouncer(milliseconds: 2000);
  Timer? searchTimer;
  var lastSearch = '';
  DashboardBloc block = DashboardBloc(appRepository: LoginRepo());
  ListingModel? model;
  bool isLoading= true;
  FilterModel? filterModel;
  @override
  void initState() {
    super.initState();
    block.add(DashboardEventSubmit());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.statusBarColor,
          statusBarIconBrightness: Brightness.light,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 5,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: const Icon(Icons.logout, color: AppColors.black),
                onPressed: () {
                  AppPreference().isLogin=false;
                  Get.toNamed(Routes.login);
                }),
          )
        ] ,

      ),
      body: BlocConsumer(
        bloc: block,
        listener: (context, state) {
          switch (state.runtimeType) {
            case DashboardLoadingState:
              isLoading = true;
              break;
            case DashboardSuccessState:
              isLoading = false;
              final successState = state as DashboardSuccessState;
              model = successState.model;
              break;
            case DashboardSearchSuccessState:
              isLoading = false;
              final successState = state as DashboardSearchSuccessState;
              model = successState.model;
              break;
            case FilterSuccessState:
              isLoading = false;
              final successState = state as FilterSuccessState;
              model = successState.model;
              break;
            case DashboardErrorState:
              isLoading = false;
              final error = state as DashboardErrorState;
              showCustomSnackBar(error.error,isError: true);
              break;
            case DashboardNetworkErrorState:
              isLoading = false;
              final error = state as DashboardNetworkErrorState;
              showCustomSnackBar(error.error,isError: true);
              break;
          }
        },
        builder: (BuildContext context, DashboardStates state){
         return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: EditTextView(
                      label: 'Search here',
                      controller: searchController,
                      focusNode: searchFocus,
                      isSearch: true,
                      onChanged: (_searchText){
                        if (searchTimer?.isActive ?? false) searchTimer?.cancel();
                        searchTimer = Timer(const Duration(milliseconds: 700), () {
                          if (lastSearch != searchController.text.toString()) {
                            lastSearch = searchController.text.toString();
                            block.add(DashboardSearchEvent(searchValue: searchController.text.toString()));
                          }
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.filter,arguments: [(FilterModel model){
                        filterModel = model;
                        Map<String, dynamic> request={
                          "key":"hair.color",
                          "value":model.hairColor
                        };
                        block.add(FilterEventSubmit(request: request));
                      },
                        filterModel,
                        (){
                        filterModel=null;
                          block.add(DashboardEventSubmit());
                        }
                      ]);
                    },
                    child: const Icon(Icons.all_inbox_outlined,
                        size: 40, color: Colors.blueGrey),
                  ),
                  const SizedBox(width: 10,)
                ],
              ),
              Expanded(child:isLoading?const Center(
                child: AppLoader(
                  type: LoaderType.activityIndicator,
                ),
              ): _listView())
            ],
          );
        },
      )
      ,
    );
  }

  _listView() {
    return (model?.users??[]).isEmpty? Center(child: Text('No Data Found', style: AppFontStyle.textBlackMedium14,)):ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: model?.users?.length??0,
      itemBuilder: (context, index) {
        return _itemView(model?.users?[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 10,
        );
      },
    );
  }

  _itemView(Users? user) {
    return  GestureDetector(
      onTap: (){
        Get.toNamed(Routes.details,arguments: [user?.id]);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric( vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              // radius: 30,
              child: SizedBox.fromSize(
                size: const Size.fromRadius(24),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: user?.image??'',
                  placeholder: (context, url) =>
                  const AppLoader(type: LoaderType.activityIndicator),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                 user?.username??'',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
