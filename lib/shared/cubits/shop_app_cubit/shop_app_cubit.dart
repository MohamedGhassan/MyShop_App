import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modeles/cart/add_cart.dart';
import 'package:shop_app/modeles/cart/product_details.dart';
import 'package:shop_app/modeles/cart/cart_data_model.dart';
import 'package:shop_app/modeles/categories_model/categories.dart';
import 'package:shop_app/modeles/favorites_model/change_favorites_model.dart';
import 'package:shop_app/modeles/favorites_model/favorites_model.dart';
import 'package:shop_app/modeles/home_model/home_model.dart';
import 'package:shop_app/modeles/login_user_model/login_user_model.dart';
import 'package:shop_app/modules/category/category.dart';
import 'package:shop_app/modules/favorite/favorite.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/seetings/settings.dart';
import 'package:shop_app/shared/componentes/componentes.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;


  void change(int index) {
    currentIndex = index;
    emit(ShopAppBottomNav());
  }

  List<Widget> screens = [
    ProductsScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  bool? inFavorite;

  HomeModel? homeModel;
  Map<int, bool> favorite = {};

  void getModelData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorite.addAll({element.id: element.inFavorites});
      });
      print(favorite.toString());
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  CategoryModel? categoryModel;

  void getCategory() {
    DioHelper.getData(url: CATEGORY).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(CategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorite(int productId) {
    favorite[productId] = !favorite[productId]!;
    emit(ChangeSuccessState());

    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!(changeFavoritesModel!.status!)) {
        favorite[productId] = !favorite[productId]!;
      } else {
        getFavorite();
      }

      emit(ChangeFavoriteSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorite[productId] = !favorite[productId]!;

      emit(ChangeFavoriteErrorState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavorite() {
    if (token != null) {
      emit(FavoriteLoadingState());
      DioHelper.getData(url: FAVORITES, token: token).then((value) {
        favoriteModel = FavoriteModel.fromJson(value.data);

        emit(FavoriteSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(FavoriteErrorState());
      });
    }
  }

  LoginModel? userModel;

  void getSettings() {
    if (token != null) {
      emit(UserLoadingState());

      DioHelper.getData(url: PROFILE, token: token).then((value) {
        userModel = LoginModel.fromJson(value.data);
        emit(UserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(UserErrorState());
      });
    }
  }

  void putData({
    required String name,
    required String phone,
    required String email,
  }) {
    if (token != null) {
      emit(UpdateLoadingState());

      DioHelper.putData(
              url: UpdateProfile,
              data: {'name': name, 'phone': phone, 'email': email},
              token: token!)
          .then((value) {
        userModel = LoginModel.fromJson(value.data);
        emit(UpdateSuccessState(userModel!));
      }).catchError((error) {
        print(error.toString());
        emit(UpdateErrorState());
      });
    }
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails(int productID) {
    emit(ShopLoadingGetProductDetailsState());
    DioHelper.getData(url: 'products/$productID', token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetProductDetailsState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetProductDetailsState());
    });
  }

  CartModel? cartModel;

  void getCarts() {

      emit(CartLoadingState());
      DioHelper.getData(
        url: CARTS,
        token: token,
      ).then((value) {
        cartModel = CartModel.fromJson(value.data);
        emit(CartSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(CartErrorState());
      });
    }


  AddToCart? addToCart;

  void addCarts(productId) {
    if (token != null) {
      emit(CartAddLoadingState());
      DioHelper.postData(
          url: CARTS,
          data: {'product_id': productId},
          token: token!)
          .then((value) {
        addToCart = AddToCart.fromJson(value.data);
        getCarts();
        emit(CartAddSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(CartAddErrorState());
      });
    }
  }

  void deleteCarts(int productId) {
    emit(CartRemoveLoadingState());
    DioHelper.deleteData(url: '$CARTS/$productId', token: token!).then((value) {
      if (value.data['status']) {
        getCarts();
      }
      print(value.data['message']);

      emit(CartRemoveSuccessState());
    }).catchError((onError) {
      print(onError.toString());

      emit(CartRemoveErrorState());
    });
  }

  void updateQuantityOfInCartProduct(int inCartProductID, int quantity) {
    emit(CartLoadingUpdateQuantityState());
    DioHelper.putData(
      url: '$CARTS/$inCartProductID',
      data: {
        'quantity': quantity,
      },
      token: token!,
    ).then((value) {
      if (value.data['status']) {
        getCarts();
      }
      emit(CartSuccessUpdateQuantityState());
    }).catchError((error) {
      print(error.toString());
      emit(CartErrorUpdateQuantityState());
    });
  }
}
