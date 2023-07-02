import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField {
  Widget build(
    BuildContext context, {
    Widget? suffix,
    Widget? lable,
    TextInputType? keyboardType,
    String? hint,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function()? onTap,
    void Function(String)? onChanged,
    bool? isSecure,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      child: TextFormField(
        onChanged: onChanged,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[A-Za-z.,+-@ 0-9\\s]'))
        ],
        onTap: onTap,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: isSecure ?? false,
        decoration: InputDecoration(
            label: lable,
            hintText: hint,
            suffixIcon: suffix,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
