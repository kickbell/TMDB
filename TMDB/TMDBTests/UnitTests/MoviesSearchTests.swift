//
//  MoviesSearchTests.swift
//  TMDBTests
//
//  Created by jc.kim on 3/10/23.
//

import XCTest
@testable import TMDB

class MoviesSearchTests: TMDBTestCase {
    
    let networkService = NetworkServiceMock()
    
    func test_startMoviesSearch_whenTypeSearchText() {
        
        EarlGrey.selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.MoviesSearch.searchTextFieldId))
//            .perform(grey_tap())
        
        // GIVEN
//        let movies = Movies.loadFromFile("MovieSearch.json", MoviesRequestTests.self)
////        let movies = Movies.loadFromFile("Movies.json")
//        networkService.responses["/3/search/movie"] = movies
//        open(viewController: SearchMovieController(service: MoviesService()))
//
//        // WHEN
//        Page.on(MoviesSearchPage.self).search("jok")
//
//        // THEN
//        Page.on(MoviesSearchPage.self).assertMoviesCount(movies.items.count)
    }
    
}


//import XCTest
//@testable import TMDB

class TMDBTestCase: XCTestCase {
    
//    lazy var factory = ApplicationComponentsFactory(servicesProvider: ServicesProvider(network: networkService, imageLoader: imageLoader))
//    lazy var networkService = NetworkServiceTypeMock()
//    lazy var imageLoader: ImageLoaderServiceType = {
//        let mock = ImageLoaderServiceTypeMock()
//        mock.loadImageFromClosure = { _ in
//            let image = UIImage(named: "joker.jpg", in: Bundle(for: EarlGrey.self), compatibleWith: nil)
//            return .just(image)
//        }
//        return mock
//    }()

    override func setUp() {
        setupEarlGrey()
    }
    
    private func setupEarlGrey() {
//        GREYConfiguration.sharedInstance().setValue(false, forConfigKey: kGREYConfigKeyAnalyticsEnabled) // Disable Google analytics tracking
//        GREYConfiguration.sharedInstance().setValue(5.0, forConfigKey: kGREYConfigKeyInteractionTimeoutDuration) // use 5s timeout for any interaction
//        GREYTestHelper.enableFastAnimation() // increase the speed of your tests by not having to wait on slow animations.
    }
    
    struct OpenViewControllerFlags: OptionSet {
        let rawValue: Int
        
        static let presentModally = OpenViewControllerFlags(rawValue: 1 << 0)
        static let embedInNavigation = OpenViewControllerFlags(rawValue: 1 << 1)
        static let all: OpenViewControllerFlags = [.presentModally, .embedInNavigation]
    }
    
    func open(viewController: UIViewController, flags: OpenViewControllerFlags = .presentModally) {
        let viewControllerToOpen = flags.contains(.embedInNavigation) ? UINavigationController(rootViewController: viewController) : viewController
        viewControllerToOpen.modalPresentationStyle = .fullScreen
        let window = (UIApplication.shared.delegate as! FakeAppDelegate).window!
        
        if flags.contains(.presentModally) {
            window.rootViewController = UIViewController()
            window.rootViewController?.present(viewControllerToOpen, animated: false, completion: nil)
        } else {
            window.rootViewController = viewControllerToOpen
        }
    }
}
