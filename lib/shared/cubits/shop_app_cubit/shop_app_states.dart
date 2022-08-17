import 'package:shop_app/modeles/favorites_model/change_favorites_model.dart';
import 'package:shop_app/modeles/login_user_model/login_user_model.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppBottomNav extends ShopAppStates {}

class HomeLoadingState extends ShopAppStates {}

class HomeSuccessState extends ShopAppStates {}

class HomeErrorState extends ShopAppStates {}

class CategorySuccessState extends ShopAppStates {}

class CategoryErrorState extends ShopAppStates {}

class ChangeFavoriteSuccessState extends ShopAppStates {
  final ChangeFavoritesModel favoritesModel;

  ChangeFavoriteSuccessState(this.favoritesModel);
}

class ChangeFavoriteErrorState extends ShopAppStates {}

class ChangeSuccessState extends ShopAppStates {}

class FavoriteErrorState extends ShopAppStates {}

class FavoriteSuccessState extends ShopAppStates {}
class FavoriteLoadingState extends ShopAppStates {}
class UserLoadingState extends ShopAppStates {}

class UserSuccessState extends ShopAppStates {}

class UserErrorState extends ShopAppStates {}
class UpdateLoadingState extends ShopAppStates {}

class UpdateSuccessState extends ShopAppStates {
  final LoginModel model;

  UpdateSuccessState(this.model);

}

class UpdateErrorState extends ShopAppStates {}

class CartSuccessState extends ShopAppStates {}

class CartErrorState extends ShopAppStates {}
class CartLoadingState extends ShopAppStates {}
class CartAddSuccessState extends ShopAppStates {}

class CartAddErrorState extends ShopAppStates {}
class CartAddLoadingState extends ShopAppStates {}
class CartRemoveSuccessState extends ShopAppStates {}

class CartRemoveErrorState extends ShopAppStates {}
class CartRemoveLoadingState extends ShopAppStates {}
class CartSuccessUpdateQuantityState extends ShopAppStates {}

class ShopLoadingGetProductDetailsState extends ShopAppStates {}

class ShopSuccessGetProductDetailsState extends ShopAppStates {}

class ShopErrorGetProductDetailsState extends ShopAppStates {}
class CartErrorUpdateQuantityState extends ShopAppStates {}
class CartLoadingUpdateQuantityState extends ShopAppStates {}
