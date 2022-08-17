import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modeles/register_model/register_model.dart';
import 'package:shop_app/shared/cubits/register_screen/register_screen__states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? registerModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopAppRegisterLoadingState());
    DioHelper.postData(
      data: {
        "email": email,
        "password": password,
        "phone": phone,
        "name": name,
      },
      url: REGISTER,
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(ShopAppRegisterDoneState(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppRegisterErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void passwordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(RegisterPasswordShowState());
  }
}
