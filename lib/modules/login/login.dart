import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/cubits/login_screen/login_screen__states.dart';
import 'package:shop_app/shared/cubits/login_screen/login_screen_cubit.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ShopAppLoginDoneState) {
            if (state.loginModel.status) {
              CacheHelper.savetData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                ShopAppCubit.get(context).getModelData();
                ShopAppCubit.get(context).getCategory();

                ShopAppCubit.get(context).getFavorite();

                ShopAppCubit.get(context).getSettings();

                pushAndRemove(context: context, widget: ShopLayout());
              });
            } else {
              toast(text: state.loginModel.message, state: ToastState.Error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN ',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Log in now to get our offers ',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.blueGrey)),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            textKeyboard: TextInputType.emailAddress,
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'Please enter your Email';
                            },
                            textLabel: 'EmailAddress'),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            onFieldSubmitted: (value) {
                              if (state is ShopAppLoginLoadingState) {
                                Center(child: CircularProgressIndicator());
                              } else {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }
                            },
                            controller: passwordController,
                            textKeyboard: TextInputType.text,
                            prefix: Icons.lock_outline,
                            validate: (value) {
                              if (value!.isEmpty)
                                return 'Password is too short';
                            },
                            textLabel: 'Password',
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context).passwordVisibility();
                            },
                            suffix: LoginCubit.get(context).suffix),
                        SizedBox(
                          height: 20,
                        ),
                        state is ShopAppLoginLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : defaultButton(
                                text: 'login',
                                fun: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                isUpper: true),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ',
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 5,
                            ),
                            textButton(
                                text: "register now",
                                fun: () {
                                  navigateTo(
                                       context: context,
                                      widget: RegisterScreen());
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
