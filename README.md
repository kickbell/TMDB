# TMDB
TMDB(The Movie Database) API 를 사용해서 같은 앱을 다른 방법으로 구현해보았습니다.

![](https://velog.velcdn.com/images/dev_kickbell/post/beeaa984-9528-496e-9970-f1d745d407d1/image.png)

## UIKit + async/await + MVVM-C + Unit/UI Tests

### 기술정보

- 화면구현: UICollectionViewCompositionalLayout, UIKit, UIStackView
- 네트워킹: URLSession
- 비동기 프로그래밍: async/await
- 테스트: Unit Test(XCTest), UI Test(EarlGrey)
- 사용한 디자인패턴: MVC, Coordinator

### 상세설명

- 스토어 : iOS13부터 소개된 `UICollectionViewCompositionalLayout` 을 사용했습니다. 총 4개의 Section을 가지고 있고, 화면 디자인은 AppStore를 참고했습니다. 셀은 UICollectionViewCell를 코드 베이스로 커스텀 셀을 구현해서 사용했으며, 평소 `UIStackView` 위주로 화면구현하는 방식을 선호해서 `오토레이아웃 관련 코드가 매우 적다`는 이점이 있습니다.
- 검색 : UITableViewController, UISearchController 베이스로 구현되었습니다. 셀은 SearchCell과 LoadingCell 셀이 있어 스크롤시 추가로 로딩되는 데이터에 표시되도록 했습니다. 추가 데이터는 `scrollViewDidScroll` 을 트리거로 `movie.count < totalCount` 보다 작다면 `page +=1` 를 해주는 방식으로 구현되었습니다.
- 트렌드 : 가장 많은 데이터를 보여주는 화면으로 UIStackView 를 위주로 구현해서 오토레이아웃 관련 코드가 매우 적어 이해하기가 쉬우며, 가로/세로 화면 변환 대응에도 유용합니다.
- 네트워킹 : `Endpoint 프로토콜`을 선언해서 scheme, host, header, queryItems 등을 `추상화`하였고, 실제 구현은 `MoviesEndpoint 열거형과 extension의 조합`으로 구현되어 있습니다. `Moya 라이브러리`와 유사합니다. 통신은 `URLSession`을 사용하였으며, `URLRequest 생성`과 `JSON Parsing`을 테스트 하기 위해 `APIRequest 프로토콜`을 선언하여 각 케이스 별로 구현하였습니다. 비동기 작업은 코드를 더 간결하게 하기 위해 `@escaping completionHandler, Combine` 보다는 `async/await` 를 사용하였습니다.
- 사용한 디자인 패턴 : 기본 MVC 패턴으로 구현되었고, 화면전환인 라우터 부분만 `Coordinator 패턴`을 적용하였습니다. 탭바 컨트롤러를 사용하고 있으므로 `Coordinator 프로토콜`을 기반으로 각 탭별로 `StoreCoordinator, SearchCoordinator, TrendCoordinator`로 구분하였습니다. 그외 네트워킹, 이미지로더와 같은 서비스부분은 따로 분리하여 유지보수에 용이하도록 구현하였습니다.
- Unit Test : 네트워킹을 테스트하기 위해 별도의 `NetworkServiceType` 프로토콜을 선언하고 `URLSession을 주입`받아 `NetworkServiceMock` 으로 네트워킹을 대체할 수 있도록 하였습니다. `NetworkServiceMock` 에는 별도의 `[[String:Any](notion://www.notion.so/2-TMDB-API-63f2da44d0744778877e584935039f3f)]` 의 변수를 만들고 `key값`에는 `Endpoint의 path`를, `value값`에는 따로 테스트를 위해 생성한 `json 파일`을 할당하고 기대값과 맞는지 테스트하는식으로 구현하였습니다.
- UI Test : 기본적으로 제공되는 `XCUITest`는 `블랙박스 테스트`이기 때문에 테스트가 `제한적`이라고 판단했습니다. 문제를 해결하기 위해 `EarlGrey`, `swifter` 와 같은 써드파티 프레임워크를 시도해보았으나 문제가 해결되지 않았고, `UITESTING` 플래그를 추가해서 테스트시 임시 데이터를 넣는 방향으로 문제를 해결할 수 있었습니다.
