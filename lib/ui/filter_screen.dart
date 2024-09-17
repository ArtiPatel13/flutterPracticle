import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constant/app_colors.dart';
import '../constant_widget/edittext.dart';
import '../model/filter_model.dart';

class FilterScreen extends StatefulWidget {
  final Function(FilterModel)? callback;
  final Function()? reset;
  final FilterModel? filterModel;
  const FilterScreen({super.key,this.callback,this.reset,this.filterModel});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var hairColorController =  TextEditingController();
  FocusNode hairColorFocus =  FocusNode();
  var eyeColorController =  TextEditingController();
  FocusNode eyeColorFocus =  FocusNode();

  @override
  void initState() {
    super.initState();
    hairColorController.text = widget.filterModel?.hairColor??'';
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
        title: const Text(
          'Filter Page',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          EditTextView(
            label: 'Hair Color',
            controller: hairColorController,
            focusNode: hairColorFocus,
            onChanged: (_searchText){

            },
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              buildButton('APPLY', () {
                FilterModel filter = FilterModel(
                   eyeColor:eyeColorController.text.toString(),
                  hairColor: hairColorController.text.toString()
                );
                widget.callback?.call(
                    filter
                );
                Get.back();
              }),
              buildButton("RESET", () {
                widget.reset?.call(
                );
                Get.back();
              }),
            ],
          )
        ],
      ),
    );
  }

  Padding buildButton(String label, Function onClick) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Center(
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              onClick();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppColors.green),
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  label.toUpperCase(),
                  style: const TextStyle(fontSize: 16,color: AppColors.white),
                )),
          ),
        ),
      ),
    );
  }
}
