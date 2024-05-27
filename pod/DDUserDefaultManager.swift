//
//  DDUserDefaultManager.swift
//  DDUserDefaultManager
//
//  Created by Damon on 2021/7/15.
//

import UIKit
import DDKitUtil

open class DDUserDefaultManager: NSObject {
    private static let instance = DDUserDefaultManager()
    open class var shared: DDUserDefaultManager {
        return instance
    }

    //MARK: UI
    lazy var mNavigationController: UINavigationController = {
        let rootViewController = DDUserDefaultVC()
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.navigationBar.barTintColor = UIColor.white
        return navigation
    }()

}

public extension DDUserDefaultManager {
    func start() {
        self.mNavigationController.dismiss(animated: false) { [weak self] in
            guard let self = self else { return }
            DDKitUtil.shared.getCurrentVC()?.present(self.mNavigationController, animated: true, completion: nil)
        }
    }
}
