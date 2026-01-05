import 'package:flutter/material.dart';

/// 검색 시작 버튼 컴포넌트
class SearchButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const SearchButton({
    super.key,
    required this.onPressed,
    this.label = "검색 시작",
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
