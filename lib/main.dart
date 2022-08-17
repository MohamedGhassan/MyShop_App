import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/modules/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/cubits/app/app_cubit.dart';
import 'package:shop_app/shared/cubits/app/app_states.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/styles.dart';

import 'shared/cubits/bloc_provider/bloc_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  dynamic onBoardingSkip ;


  onBoardingSkip = CacheHelper.getData
    (key: 'onBoardingSkip') ;
  token = CacheHelper.getData
  (key: 'token') ;
  print ( "token $token " );
  Widget start;
  if(onBoardingSkip != null){
    if(token == ''){
      start = LoginScreen();
    }else{
      start = ShopLayout();
    }
  }else
    start = OnBoarding();
  runApp(MyApp(start: start));
}




class MyApp extends StatelessWidget {
  final Widget start ;

  MyApp({
    required this.start,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context)=> ShopAppCubit()..getModelData()..getCategory()..getFavorite()..getSettings()..getCarts()),

        BlocProvider(
            create: (context) => AppCubit())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode:
            ThemeMode.light,
            theme: lightMode,
            darkTheme: darkMode,
            debugShowCheckedModeBanner: false,
            home: start ,
          );
        },
      ),
    );
  }
}
