import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modeles/login_user_model/login_user_model.dart';
import 'package:shop_app/shared/cubits/login_screen/login_screen__states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(ShopAppInitialState());
   LoginModel ? loginModel ;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopAppLoginLoadingState());
    DioHelper.postData(
      data: {"email": email, "password": password},
      url: LOGIN,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);


      emit(ShopAppLoginDoneState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppLoginErrorState(error.toString()));
    });
  }

  bool isPassword = true;

  IconData suffix = Icons.visibility;

  void passwordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopAppPasswordShowState());
  }
}
