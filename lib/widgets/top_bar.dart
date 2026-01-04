import 'package:flutter/material.dart';

/// 상단바 컴포넌트
/// - 왼쪽: "OpenSpace" 타이틀
/// - 오른쪽: 알림 벨 아이콘
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  // AppBar의 높이를 지정합니다
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 배경색을 투명하게 (또는 원하는 색상)
      backgroundColor: Colors.transparent,
      elevation: 0, // 그림자 제거

      // 왼쪽: 앱 타이틀
      title: const Text(
        'OpenSpace',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      // 오른쪽: 알림 벨 아이콘
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          color: Colors.white,
          onPressed: () {
            // 알림 버튼을 눌렀을 때 실행할 코드
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('알림 기능 준비 중')),
            );
          },
        ),
      ],
    );
  }
}

