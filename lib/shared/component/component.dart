import 'package:flutter/material.dart';

class MyComponents{

  static navigateAndFinish(BuildContext context,Widget screen)=> Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
          (route) => false);
  static navigateTo(BuildContext context,Widget screen)=>Navigator.push(context, MaterialPageRoute(builder: (context) =>screen,));



  static Widget defaultFormField({
    required TextEditingController controller,
    required TextInputType type,
    void Function(String)? onChange,
    String? Function(String?)? validator,
    required String label,
    required IconData prefix,
    bool isPassword = false,
    IconData? suffix,
    void Function()? suffixPressed,
    void Function()? onTap,
    bool readOnly = false,
  }) =>
      TextFormField(
        cursorRadius: const Radius.circular(10.0),
        // validator: (s) {
        //   validate(s);
        // },
        validator: validator,
        textInputAction: TextInputAction.next,
        readOnly: readOnly,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onChanged: onChange,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
            icon: Icon(suffix),
            onPressed: suffixPressed!,
          )
              : null,
        ),
      );

}

