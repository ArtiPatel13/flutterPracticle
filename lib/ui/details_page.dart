import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practicle/bloc/events/dashboard_event.dart';
import 'package:flutter_practicle/model/details_model.dart';
import 'package:get/get.dart';

import '../bloc/dashboard_bloc.dart';
import '../bloc/states/dashboard_state.dart';
import '../constant/app_colors.dart';
import '../constant/app_loader.dart';
import '../constant/custom_snackbar.dart';
import '../constant/font_style.dart';
import '../repo/login_repo.dart';

class DetailsPage extends StatefulWidget {
  final int id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DashboardBloc block = DashboardBloc(appRepository: LoginRepo());
  bool isLoading = true;
  DetailsModel? model;

  @override
  void initState() {
    super.initState();
    block.add(DashboardDetailsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.statusBarColor,
          statusBarIconBrightness: Brightness.light,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 5,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          model?.username ?? 'Details Page',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      body: BlocConsumer(
          bloc: block,
          listener: (context, state) {
            switch (state.runtimeType) {
              case DashboardLoadingState:
                isLoading = true;
                break;
              case DashboardDetailsSuccessState:
                isLoading = false;
                final successState = state as DashboardDetailsSuccessState;
                model = successState.model;
                break;
              case DashboardErrorState:
                isLoading = false;
                final error = state as DashboardErrorState;
                showCustomSnackBar(error.error, isError: true);
                break;
              case DashboardNetworkErrorState:
                isLoading = false;
                final error = state as DashboardNetworkErrorState;
                showCustomSnackBar(error.error, isError: true);
                break;
            }
          },
          builder: (BuildContext context, DashboardStates state) {
            return isLoading ? const Center(
              child: AppLoader(
                type: LoaderType.activityIndicator,
              ),
            ) : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipOval(
                      // radius: 30,
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(44),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: model?.image ?? '',
                          placeholder: (context, url) =>
                          const AppLoader(type: LoaderType.activityIndicator),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Center(child: Text('${model?.firstName} ${model?.lastName}', style: AppFontStyle.textBlackMedium14,)),
                  columnLabelView(label: "Gender", value: model?.gender),
                  columnLabelView(label: "DOB", value: model?.birthDate),
                  columnLabelView(
                      label: "Blood Group", value: model?.bloodGroup),
                  columnLabelView(
                      label: "Height", value: model?.height.toString() ?? ''),
                  columnLabelView(
                      label: "Weight", value: model?.weight.toString() ?? ''),
                  columnLabelView(label: "Eye Color", value: model?.eyeColor),
                  columnLabelView(
                      label: "Hair Color", value: model?.hair?.color),
                  columnLabelView(
                      label: "Address", value: '${model?.address?.address}, ${model?.address?.city}, ${model?.address?.state}, ${model?.address?.postalCode}'),
                ],
              ),
            );
          })
      ,
    );
  }

  Widget columnLabelView({required String label, required String? value}) {
    return (value?.isEmpty == true ||
        value
            .toString()
            .trim()
            .isEmpty ||
        value == null)
        ? Container()
        : Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label :',
            style: AppFontStyle.gray14TextStyle,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text(
                (value).trim(),
                style: AppFontStyle.black16TextStyle900,
              )),
        ],
      ),
    );
  }
}
