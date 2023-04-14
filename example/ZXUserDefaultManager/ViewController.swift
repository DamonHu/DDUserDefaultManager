//
//  ViewController.swift
//  ZXUserDefaultManager
//
//  Created by Damon on 2021/7/15.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }

    func createUI() {
        self.view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = UIColor.red
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(_click), for: .touchUpInside)
    }

    @objc func _click() {
        ZXUserDefaultManager.shared.start()
    }

}

