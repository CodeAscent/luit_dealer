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
  final bool? isPassword;
  final VoidCallback? onTap;

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
    this.isPassword = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: readOnly ?? false,
        child: TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          maxLength: maxLength,
          obscureText: isPassword!,
          validator: validator ??
                  (val) {
                if (val == '') {
                  return 'Enter $hint';
                } else if (isPhone! && val!.length < 10) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
          controller: controller,
          keyboardType: type,
          inputFormatters: [
            if (type == TextInputType.phone)
              FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            suffixIcon: suffix,
            counterText: '',
            hintText: hint,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
