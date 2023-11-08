import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class InputBox extends StatefulWidget {
  const InputBox({
    Key? key,
    required this.hintText,
    required this.helperText,
    required this.onChange,
    required this.controller,
    this.type = TextInputType.name,
    this.action = TextInputAction.next,
    this.size = 12,
    this.isNumber = true,
    this.isPassword = false,
  }) : super(key: key);

  final String hintText;
  final String helperText;
  final Function(String value) onChange;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;
  final int size;
  final bool isNumber;
  final bool isPassword;

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.type,
      onChanged: widget.onChange,
      obscureText: widget.isPassword && !_isPasswordVisible,
      textInputAction: widget.action,
      autocorrect: false,
      autofocus: true,
      controller: widget.controller,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontSize: widget.size.sp),
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.symmetric(horizontal: 5.sp),
        hintText: widget.hintText,
        helperText: widget.helperText,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 224, 241, 255),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }
}
