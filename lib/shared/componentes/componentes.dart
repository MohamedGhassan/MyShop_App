import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/cubits/shop_app_cubit/shop_app_cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void pushAndRemove({context, widget}) => {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => widget), (route) => false)
    };

void navigateTo({required context, required widget}) =>
    {Navigator.push(context, MaterialPageRoute(builder: (context) => widget))};

Widget textButton({required String text, required VoidCallback? fun}) =>
    TextButton(onPressed: fun, child: Text(text.toUpperCase()));

Widget defaultButton({
  double radius = 0,
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUpper = true,
  required String text,
  required void fun(),
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        child: Text(
          " ${isUpper ? text.toUpperCase() : text} ",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: fun,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType textKeyboard,
  IconData? suffix,
  String? helper = '',
  GestureTapCallback? onTaped,
  bool isPassword = false,
  required IconData prefix,
  ValueChanged<String>? onchange,
  ValueChanged<String>? onFieldSubmitted,
  required FormFieldValidator<String> validate,
  required String textLabel,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      validator: validate,
      controller: controller,
      keyboardType: textKeyboard,
      obscureText: isPassword,
      decoration: InputDecoration(       helperText: '$helper',

        labelText: textLabel,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
      onChanged: onchange,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTaped,
    );

void toast({
  required String text,
  required ToastState state
   }) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { Warning, Error, Success }

Color? color;

Color chooseToastColor(ToastState state) {
  switch (state) {
    case (ToastState.Success):
      color = Colors.green;
      break;

    case (ToastState.Error):
      color = Colors.red;
      break;
    case (ToastState.Warning):
      color = Colors.amber;
      break;
  }
  return color!;
}

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      pushAndRemove(context: context, widget: LoginScreen());
      ShopAppCubit.get(context).currentIndex = 0;
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token;

Widget buildAddToCartButton({
  double? size = double.infinity,
  required String label,
  required void Function() onPressed,
}) {
  return Container(
    width: size,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20.0),
        elevation: 10,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(label),
        ],
      ),
    ),
  );
}
bool isPhoneNoValid(value) {
  if (value == null) return false;
  final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  return regExp.hasMatch(value);
}

