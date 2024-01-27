# kofoos

# MVVM 패턴
view        : 사용자에게 보여지는 영역
viewModel   : view의 상태를 관리하고 view의 비즈니스 로직을 담당
Model       : 데이터 설계
repository  : 데이터 저장소라는 뜻으로 dataLayer인 dataSource에 접근
dataSource  : 데이터를 가져오는 영역

요청 흐름 : view → viewModel → Model
알림 흐름 : view ← viewModel ← Model

# 디렉토리 구조
config - 앱의 전반적인 구성요소
    → route
    → theme
core : 앱에서 전역적으로 사용되는 요소
    → utils
data : data layer 관련 요소들.
    → dataSource (api 호출 클래스)
    → model (api 결과 데이터 클래스)
    → repository (api 클래스를 주입받아 사용하는 구현체)
ui : 사용자에게 보여줄 화면, 상호작용하는 viewModel
    → 개별 폴더 (page, view, view_model 이 한 세트로 구성)