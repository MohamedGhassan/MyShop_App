
import 'package:shop_app/modeles/register_model/register_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}

class ShopAppRegisterDoneState extends RegisterStates{

  final RegisterModel registerModel;

  ShopAppRegisterDoneState(this.registerModel);
}
class ShopAppRegisterErrorState extends RegisterStates{
  final String error;

  ShopAppRegisterErrorState(this.error);


}
class ShopAppRegisterLoadingState extends RegisterStates{}
class RegisterPasswordShowState extends RegisterStates{}
