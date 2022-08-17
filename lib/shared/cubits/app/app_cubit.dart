import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubits/app/app_states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit < AppStates> {
  AppCubit() : super(AppInitialState());
static AppCubit get(context)=>BlocProvider.of(context);
  bool isDark =false;
  void changeTheme ({        bool ? fromShared}

      ) {
    if (fromShared!=null ) {
      isDark=fromShared ;

      emit(LightState());
    }
    else
      isDark = !isDark;
    CacheHelper.savetData(value: isDark, key: 'isDark');
    emit(LightState());
  }

  }

