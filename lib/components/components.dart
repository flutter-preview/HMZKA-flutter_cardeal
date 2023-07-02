import 'package:flutter/material.dart';

import '../constants.dart';

Widget dropdownButtonField(
    {required List<DropdownMenuItem<dynamic>>? items,
    required void Function(dynamic)? onChanged,
    required BuildContext context,
    required String? Function(dynamic)? validator,
    Widget? hint}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownButtonFormField(
      menuMaxHeight: getScreenSize(context).height / 3,
      items: items,
      hint: hint,
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    ),
  );
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

void showSnackBarr({
  required String msg,
  Color? color,
}) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      msg,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18),
    ),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}

Size getScreenSize(context) {
  return MediaQuery.of(context).size;
}

pushNavigation(context, screen) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => screen,
  ));
}

popNavigation(context) {
  Navigator.of(context).pop();
}

pushAndRemoveUntil(context, screen) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false);
}
