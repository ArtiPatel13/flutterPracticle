
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practicle/bloc/states/login_state.dart';
import 'package:flutter_practicle/constant/app_preference.dart';
import 'package:flutter_practicle/constant/custom_snackbar.dart';
import 'package:flutter_practicle/repo/login_repo.dart';
import 'package:get/get.dart';

import '../bloc/events/login_event.dart';
import '../bloc/login_bloc.dart';
import '../constant/app_colors.dart';
import '../constant/app_routes.dart';
import '../constant/aspect_size.dart';
import '../constant/circular_indicator.dart';
import '../constant/strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController =  TextEditingController();
  final _passwordController =  TextEditingController();
  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus =  FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool isLoading = false;
  LoginBloc block = LoginBloc(appRepository: LoginRepo());
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return
      BlocConsumer(
        bloc: block,
        listener: (context, state) {
          switch (state.runtimeType) {
            case LoginLoadingState:
              isLoading =true;
              break;
            case LoginSuccessState:
              isLoading =false;
              AppPreference().isLogin= true;
              Get.toNamed(Routes.listing);
              break;
            case LoginErrorState:
              isLoading =false;
              final error = state as LoginErrorState;
              showCustomSnackBar(somethingWentWrong,isError: true);
              break;
            case LoginNetworkErrorState:
              isLoading =false;
              final error = state as LoginErrorState;
              showCustomSnackBar(error.error,isError: true);
              break;
          }
        },
          builder: (BuildContext context, LoginStates state) {
          return Scaffold(
              backgroundColor: AppColors.splashGreen,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding:const EdgeInsets.only(
                      left: 20.00,
                      right: 20.00,
                      bottom: 20.00,
                      top: 50.00
                  ),
                  child:  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height:  60.00,
                        ),
                        Image.asset('images/ic_login.png',height: 120,),

                        const SizedBox(
                          height:  35.00,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: AspectSize.getWidthSize(
                                  context: context, sizeConstant: 60),
                              left: AspectSize.getWidthSize(
                                  context: context, sizeConstant: 20),
                              right: AspectSize.getWidthSize(
                                  context: context, sizeConstant: 20)),
                          child: _buildTextFiled(userNameFocus,
                              _userNameController, userName, node),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: AspectSize.getWidthSize(
                                  context: context, sizeConstant: 20),
                              left: AspectSize.getWidthSize(
                                  context: context, sizeConstant: 20),
                              right: AspectSize.getWidthSize(
                                  context: context, sizeConstant: 20)),
                          child: _buildTextFiled(passwordFocus,
                              _passwordController, password, node),
                        ),
                           Padding(
                          padding: EdgeInsets.only(
                              top: AspectSize.getWidthSize(
                                  context: context, sizeConstant: 30),
                              bottom: AspectSize.getWidthSize(
                                  context: context, sizeConstant: 80)),
                          child:isLoading
                              ? const CircularIndicator()
                              :   loginButton(),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
          }
      );
  }

  Widget _buildTextFiled(FocusNode focusNode, TextEditingController controller,
      String hint, FocusScopeNode node) {
    return TextFormField(
      cursorColor: AppColors.theme,
      autofocus: false,
      controller: controller,
      obscureText: hint == password ? _isHidden : false,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      onEditingComplete: () => node.nextFocus(),
      validator: (value) {
        if (value?.toString().trim().isEmpty ?? true) {
          switch (hint) {
            case userName:
              return pleaseEnterUserName;
            case password:
              return pleaseEnterPassword;
          }
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: hint == password ? _togglePasswordView : null,
          child: Icon(
            hint == password
                ? _isHidden
                ? Icons.visibility
                : Icons.visibility_off
                : null,
            size: AspectSize.getWidthSize(context: context, sizeConstant: 24),
            color: AppColors.black,
          ),
        ),
        hintText: hint,
        isDense: true,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.fromLTRB(
            AspectSize.getWidthSize(context: context, sizeConstant: 20),
            AspectSize.getWidthSize(context: context, sizeConstant: 15),
            AspectSize.getWidthSize(context: context, sizeConstant: 10),
            AspectSize.getWidthSize(context: context, sizeConstant: 15)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.white, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.white, width: 1.5)),
        labelStyle: TextStyle(
          color:
          userNameFocus.hasFocus ? AppColors.theme : AppColors.black,
        ),
      ),
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget loginButton() {
    return InkWell(
      child: Container(
        width: AspectSize.getWidthSize(context: context, sizeConstant: 120),
        height: AspectSize.getWidthSize(context: context, sizeConstant: 40),
        decoration: BoxDecoration(
            color: AppColors.splashGreen,
            border: Border.all(color: AppColors.white, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () {
        if (_formKey.currentState?.validate() ?? false) {
          block.add(LoginEventSubmit(userName: _userNameController.text.toString(),
              password: _passwordController.text.toString()));
        } else {
        }
      },
    );
  }
}
