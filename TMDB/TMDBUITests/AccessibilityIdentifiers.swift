//
//  AccessibilityIdentifiers.swift
//  TMDB
//
//  Created by jc.kim on 3/10/23.
//

import Foundation

struct AccessibilityIdentifiers {
    struct Store {
        static let tabBarItem = "\(Store.self).tabBarItem"
        static let collectionView = "\(Store.self).collectionView"
        static let featureCell = "\(Store.self).featureCell"
        static let threeTableCell = "\(Store.self).threeTableCell"
        static let smallTableCell = "\(Store.self).smallTableCell"
        static let squareCell = "\(Store.self).squareCell"
        static let featureTitle = "\(Store.self).featureCell.title"
        static let threeTableTitle = "\(Store.self).threeTableCell.title"
        static let smallTableTitle = "\(Store.self).smallTableCell.title"
        static let squareTitle = "\(Store.self).squareCell.title"
    }
    
    struct Search {
        static let tabBarItem = "\(Search.self).tabBarItem"
        static let searchTextField = "\(Search.self).searchTextField"
        static let tableView = "\(Trend.self).tableView"
        static let searchCell = "\(Trend.self).searchCell"
        static let title = "\(Trend.self).searchCell.title"
    }
    
    struct Trend {
        static let tabBarItem = "\(Trend.self).tabBarItem"
        static let name = "\(Trend.self).name"
    }
    
    struct Detail {
        static let name = "\(Detail.self).name"
    }
}
