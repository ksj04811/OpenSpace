import 'package:flutter/material.dart';

/// 검색창 컴포넌트
class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.label = "검색",
    this.hint = "목적지를 입력하세요",
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: label,
      hint: hint,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: hint,
        ),
      ),
    );
  }
}
