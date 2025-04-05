# SimpleImageListCombine

SimpleImageListCombine은 Swift의 Combine 프레임워크를 활용하여 이미지 목록을 표시하고 상세 정보를 제공하는 iOS 애플리케이션입니다. 반응형 프로그래밍 패턴을 기반으로 구현되었으며, 모던 Swift 개발 방식을 따릅니다.

## 주요 기능

- 이미지 목록 표시 (MainView)
- 이미지 상세 정보 보기 (DetailView)
- API를 통한 이미지 데이터 로드
- Combine을 활용한 반응형 데이터 처리

## 기술 스택

- Swift
- SwiftUI
- Combine (반응형 프로그래밍 프레임워크)
- SwiftLint (코드 스타일 및 규칙 검사)
- Quick (BDD 스타일 테스트 프레임워크)
- Nimble (테스트를 위한 매처 프레임워크)

## 프로젝트 구조

프로젝트는 다음과 같은 구조로 구성되어 있습니다:

```
SimpleImageListCombine/
├── API/                  # 네트워크 및 API 관련 코드
├── Presentation/         # UI 및 화면 표시 로직 (MainView, DetailView)
├── Util/Extension/       # 유틸리티 및 확장 기능
├── Assets.xcassets/      # 이미지 및 앱 아이콘
├── ColorAssets.xcassets/ # 색상 에셋
└── Preview Content/      # SwiftUI 프리뷰 관련 리소스
```

## 요구 사항

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## 설치 방법

1. 저장소를 클론합니다:
```bash
git clone https://github.com/Movegit/SimpleImageListCombine.git
```

2. Xcode에서 프로젝트를 엽니다:
```bash
cd SimpleImageListCombine
open SimpleImageListCombine.xcodeproj
```

3. 필요한 패키지가 자동으로 설치됩니다. 설치가 완료되면 앱을 빌드하고 실행할 수 있습니다.

## Combine 프레임워크

이 프로젝트는 Apple의 Combine 프레임워크를 사용하여 비동기 이벤트 처리와 데이터 흐름을 관리합니다. Combine은 시간에 따라 값을 처리하기 위한 선언적 Swift API를 제공하며, 다음과 같은 이점이 있습니다:

- 비동기 이벤트 처리 간소화
- 데이터 흐름의 조합 및 변환 용이
- 메모리 관리 자동화
- UI 업데이트와 데이터 바인딩 간소화

## 테스트

프로젝트에는 다음과 같은 테스트가 포함되어 있습니다:

- 단위 테스트 (SimpleImageListCombineTests)
- UI 테스트 (SimpleImageListCombineUITests)
- MainView 및 DetailView 테스트

이 프로젝트는 BDD(Behavior-Driven Development) 스타일의 테스트를 위해 Quick과 Nimble 프레임워크를 사용합니다:
- **Quick**: BDD 스타일의 테스트 구조를 제공하여 가독성 높은 테스트 코드 작성
- **Nimble**: 직관적인 매처(matcher)를 사용하여 테스트 결과 검증

테스트를 실행하려면 Xcode의 테스트 네비게이터를 사용하거나 다음 명령을 실행하세요:

```bash
xcodebuild test -project SimpleImageListCombine.xcodeproj -scheme SimpleImageListCombine -destination 'platform=iOS Simulator,name=iPhone 13'
```

## 코드 스타일

이 프로젝트는 SwiftLint를 사용하여 코드 스타일과 규칙을 검사합니다. 설정은 `.swiftlint.yml` 파일에 정의되어 있습니다.

## SwiftUI와 Combine의 통합

이 프로젝트는 SwiftUI와 Combine을 함께 사용하여 선언적 UI와 반응형 데이터 처리를 결합합니다:

- SwiftUI의 `@Published` 속성과 Combine의 Publisher를 연결
- 네트워크 요청 결과를 UI에 바인딩
- 사용자 입력에 반응하는 데이터 흐름 구현

## 기여 방법

1. 이 저장소를 포크합니다.
2. 새로운 기능 브랜치를 생성합니다 (`git checkout -b feature/amazing-feature`).
3. 변경 사항을 커밋합니다 (`git commit -m 'Add some amazing feature'`).
4. 브랜치에 푸시합니다 (`git push origin feature/amazing-feature`).
5. Pull Request를 생성합니다.

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 연락처

프로젝트 관리자: [Movegit](https://github.com/Movegit)
