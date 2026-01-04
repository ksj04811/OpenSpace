import 'package:flutter/material.dart';

/// 하단 네비게이션 바 컴포넌트
class BottomBar extends StatelessWidget {
  final int currentIndex; // 현재 선택된 탭 인덱스
  final Function(int) onTap; // 탭을 눌렀을 때 실행할 함수

  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // 선택된 탭에 노란색 상단 선을 추가하는 헬퍼 함수
  Widget _buildIconWithIndicator(IconData icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 노란색 상단 선 (하단바 상단에 위치)
        if (isSelected)
          Container(
            width: 40, // 선의 너비 (아이콘보다 약간 넓게)
            height: 4, // 선의 두께 (굵은 선)
            decoration: BoxDecoration(
              color: Colors.amber, // 노란색
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        if (!isSelected)
          const SizedBox(height: 4), // 선택되지 않은 경우 공간만 확보
        Icon(icon),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap, // 탭을 누르면 부모 위젯에서 정의한 함수 실행

      // 선택된 항목의 색상
      selectedItemColor: Colors.amber, // 노란색
      unselectedItemColor: Colors.white, // 흰색

      // 아이템 스타일
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 12),

      // 배경색 (어두운 배경)
      backgroundColor: const Color(0xFF1E1E2E),

      type: BottomNavigationBarType.fixed, // 항목이 4개 이상일 때 필요

      items: [
        BottomNavigationBarItem(
          icon: _buildIconWithIndicator(Icons.search, currentIndex == 0),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: _buildIconWithIndicator(
              Icons.warning_outlined, currentIndex == 1),
          label: '위험 요소',
        ),
        BottomNavigationBarItem(
          icon: _buildIconWithIndicator(
              Icons.person_outline, currentIndex == 2),
          label: '내 정보',
        ),
        BottomNavigationBarItem(
          icon: _buildIconWithIndicator(
              Icons.settings_outlined, currentIndex == 3),
          label: '설정',
        ),
      ],
    );
  }
}

