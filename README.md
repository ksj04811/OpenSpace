# flutter_tutorial
어쩌다 보니 튜토리얼 하던 창에서 그냥 시작해버려서... 나중에 프로젝트 이름 전체 바꿀게요

## 버전 정보

1. Flutter 3.38.5 (이번에 새로 다운로드했다면 상관없을듯)
   Tools • Dart 3.10.4 • DevTools 2.51.1 (자동)
   
2. pubspec.yaml 파일 내 의존 패키지 버전
(line 30 - dependencies 내부)
- cupertion_icons: ^1.0.8
- speech_to_text: ^6.6.0
- flutter_map: ^6.1.0
- latlong2: ^0.9.0
- geolocator: ^10.1.0

어차피 파일 내에 있는 거라 신경 안 써도 됨.
다만 첫 실행 전에 pubspec.yaml 파일 들어가서 ctrl+S 누르고 시작하면 좋을 듯. (다운로드)

권한 허가 알림 관련 내용을 android\app\src\main\AndroidManifest.xml과 ios\Runner\Info.plist에 각각 추가해 둠.
새로운 패키지 추가할 예정이라면 여기도 수정해야 할 수 있음.

## 실행 방법
Terminal 들어가서 "flutter run" 입력

## 폴더 구조
(현재 상태)
```bash
lib/
 ├ main.dart
 ├ mode_select_page.dart    // 앱 첫 화면, 도움 모드 선택
 ├ map_search_page.dart     // 지도 + 검색창 화면 (통합 필요)
```

## 협업 정보
1.  **개인 개발 브랜치 생성 (최초 1회)**: `main` 브랜치를 기준으로 자신의 개인 개발 브랜치를 생성합니다.

    ```bash
    # 'moo' 개발자의 경우
    git checkout -b dev/moo
    git push origin dev/moo
    ```

2.  **개발 진행**: 자신의 개인 개발 브랜치에서 자유롭게 코드를 추가하고 커밋하며 기능을 완성해 나갑니다.

    ```bash
    git checkout dev/moo
    # ... 코드 작업 및 커밋 ...
    git push origin dev/moo
    ```

3.  **`main` 브랜치와 동기화**: 다른 팀원의 작업물이 `main`에 병합되면, 자신의 개인 개발 브랜치에 최신 코드를 반영하여 충돌을 방지합니다.

    ```bash
    # 1. main 브랜치의 최신 코드를 가져옵니다.
    git checkout main
    git pull origin main

    # 2. 내 개인 개발 브랜치로 이동하여 main의 변경사항을 병합합니다.
    git checkout dev/moo
    git merge main
    ```

    > ❗️ **Tip**: `main`으로 통합(PR)하기 전에 이 과정을 진행하면 좋습니다.

4.  **Pull Request (PR) 생성**: 개인 브랜치에서 기능 개발이 완료되면, `main` 브랜치로 병합하기 위해 **Pull Request**를 생성합니다.
    - PR의 제목과 설명에 어떤 기능이 추가되었는지 명확하게 작성합니다.
    - 팀원들의 코드 리뷰를 거친 후 `main` 브랜치에 병합합니다.
### ✍️ 커밋 메시지 컨벤션

#### 타입
- feat : 새로운 기능 추가
- fix : 버그 수정
- docs : 문서 수정
- style : 코드 포맷팅 (세미콜론, 띄어쓰기 등 비즈니스 로직에 영향 없는 변경)
- refactor : 코드 리팩토링
- test : 테스트 코드 추가/수정
- chore : 빌드/패키지 관리 변경 등 기타 잡무
- comment : 주석 추가/수정
- rename : 파일 혹은 폴더명을 수정하거나 옮기는 작업

<예시>
- feat: 로그인 페이지 UI 구현
- fix: 헤더 네비게이션 버그 수정
- docs: README 설치 방법 업데이트
- style: prettier 적용
- refactor: API 호출 로직 공통 함수로 분리

---------------------------------------------------------
## Getting Started

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
