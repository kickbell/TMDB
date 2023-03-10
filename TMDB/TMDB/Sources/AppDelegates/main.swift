//
//  main.swift
//  TMDB
//
//  Created by jc.kim on 3/10/23.
//


import UIKit

private let fakeAppDelegateClass: AnyClass? = NSClassFromString("TMDBTests.FakeAppDelegate")
private let appDelegateClass: AnyClass = fakeAppDelegateClass ?? AppDelegate.self

_ = UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
