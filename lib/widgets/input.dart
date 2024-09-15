// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.icon,
    required this.hint,
    required this.editingController,
    this.obscure,
    this.enable = true,
    this.onTapBox,
  });
  final String icon;
  final String hint;
  final TextEditingController editingController;
  final bool? obscure;
  final bool enable;
  final VoidCallback? onTapBox;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBox,
      child: TextField(
        controller: editingController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff070623),
        ),
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          enabled: enable,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff070623),
          ),
          fillColor: Color(0x0FFFFFFFF),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: const Color(0xFF4A1DFF),
              width: 2,
            ),
          ),
          prefixIcon: UnconstrainedBox(
            alignment: Alignment(0.5, 0),
            child: Image.asset(
              icon,
              width: 24,
              height: 24,
            ),
          )
        ),
      ),
    );
  }
}
