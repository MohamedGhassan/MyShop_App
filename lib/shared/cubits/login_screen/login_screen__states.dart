import 'package:shop_app/modeles/login_user_model/login_user_model.dart';

abstract class LoginStates{}
class ShopAppInitialState extends LoginStates{}
class ShopAppLoginDoneState extends LoginStates{

  final LoginModel loginModel;

  ShopAppLoginDoneState(this.loginModel);

}
class ShopAppLoginErrorState extends LoginStates{
  final String error;

  ShopAppLoginErrorState(this.error);


}
class ShopAppLoginLoadingState extends LoginStates{}
class ShopAppPasswordShowState extends LoginStates{}
