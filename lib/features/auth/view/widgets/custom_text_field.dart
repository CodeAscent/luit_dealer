import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? hint;
  final int? maxLength;
  final TextInputType? type;
  final Widget? suffix;
  final bool? readOnly;
  final bool? isPhone;
  final String? initialValue;
  const CustomTextField({
    super.key,
    this.validator,
    this.controller,
    this.hint,
    this.maxLength,
    this.type,
    this.suffix,
    this.readOnly,
    this.onChanged,
    this.isPhone = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      maxLength: maxLength,
      validator: validator ??
          (val) {
            if (val == '') {
              return 'enter $hint';
            } else if (isPhone! && val!.length < 10) {
              return 'please enter a valid phone number';
            }
            return null;
          },
      controller: controller,
      readOnly: readOnly ?? false,
      keyboardType: type,
      inputFormatters: [
        if (type == TextInputType.phone) FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        suffixIcon: suffix,
        counterText: '',
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
