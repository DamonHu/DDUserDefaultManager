//
//  DDUserDefaultEditVC.swift
//  DDUserDefaultManager
//
//  Created by Damon on 2021/7/16.
//

import UIKit
import DDUtils

class DDUserDefaultEditVC: UIViewController {
    private var model: DDDataCellModel
    
    init(model: DDDataCellModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarItem = UIBarButtonItem(title: "save".DDLocaleString, style: .plain, target: self, action: #selector(_rightBarItemClick))
        self.navigationItem.rightBarButtonItem = rightBarItem
        self._createUI()
        self._loadData()
    }

    //MARK: UI
    lazy var mTitleLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.textAlignment = .center
        tLabel.numberOfLines = 2
        tLabel.font = .systemFont(ofSize: 16, weight: .medium)
        tLabel.textColor = UIColor.dd.color(hexValue: 0x333333)
        return tLabel
    }()

    lazy var mSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Bool", "Number", "String", "Object"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(_changeType), for: .valueChanged)
        return segment
    }()
    
    lazy var mValueSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["true", "false"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.isHidden = true
        return segment
    }()
    
    lazy var mTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 14)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.dd.color(hexValue: 0xeeeeee).cgColor
        return textView
    }()
}

extension DDUserDefaultEditVC {
    @objc func _rightBarItemClick() {
        switch self.mSegment.selectedSegmentIndex {
            case 0:
                UserDefaults.standard.set(mValueSegment.selectedSegmentIndex == 0 ? true : false, forKey: model.key)
            case 1:
                UserDefaults.standard.set(Double(String(mTextView.text)) ?? 0, forKey: model.key)
            case 2:
                UserDefaults.standard.set(mTextView.text, forKey: model.key)
            default:
                if let jsonData = mTextView.text.data(using: .utf8), let object = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
                    UserDefaults.standard.set(object, forKey: model.key)
                } else {
                    UserDefaults.standard.set(mTextView.text, forKey: model.key)
                }
        }
        self.navigationController?.popViewController(animated: true)
    }

    func _createUI() {
        self.view.backgroundColor = UIColor.dd.color(hexValue: 0xffffff)
        self.view.addSubview(mTitleLabel)
        mTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        mTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        mTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        self.view.addSubview(mSegment)
        mSegment.leftAnchor.constraint(equalTo: self.mTitleLabel.leftAnchor).isActive = true
        mSegment.rightAnchor.constraint(equalTo: self.mTitleLabel.rightAnchor).isActive = true
        mSegment.topAnchor.constraint(equalTo: self.mTitleLabel.bottomAnchor, constant: 30).isActive = true
        mSegment.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.view.addSubview(mValueSegment)
        mValueSegment.leftAnchor.constraint(equalTo: self.mSegment.leftAnchor).isActive = true
        mValueSegment.rightAnchor.constraint(equalTo: self.mSegment.rightAnchor).isActive = true
        mValueSegment.topAnchor.constraint(equalTo: self.mSegment.bottomAnchor, constant: 10).isActive = true
        mValueSegment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(mTextView)
        mTextView.leftAnchor.constraint(equalTo: self.mSegment.leftAnchor).isActive = true
        mTextView.rightAnchor.constraint(equalTo: self.mSegment.rightAnchor).isActive = true
        mTextView.topAnchor.constraint(equalTo: self.mSegment.bottomAnchor, constant: 10).isActive = true
        mTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }

    func _loadData() {
        mTitleLabel.text = model.key
        if model.value is Bool {
            mSegment.selectedSegmentIndex = 0
        } else if model.value is NSNumber {
            mSegment.selectedSegmentIndex = 1
        } else if model.value is String {
            mSegment.selectedSegmentIndex = 2
        } else if (model.value is NSArray || model.value is NSDictionary) {
            mSegment.selectedSegmentIndex = 3
        }
        self._changeType()
    }

    @objc func _changeType() {
        mValueSegment.isHidden = true
        mTextView.isHidden = false
        mTextView.resignFirstResponder()
        switch self.mSegment.selectedSegmentIndex {
            case 0:
                mValueSegment.isHidden = false
                mTextView.isHidden = true
                mValueSegment.selectedSegmentIndex = "\(model.value)".boolValue ? 0 : 1
            case 1:
                mTextView.keyboardType = .decimalPad
                if model.value is NSNumber {
                    mTextView.text = "\(model.value)"
                } else {
                    mTextView.text = "\(Double("\(model.value)") ?? 0)"
                }
            default:
                mTextView.keyboardType = .default
                if JSONSerialization.isValidJSONObject(model.value), let jsonData = try? JSONSerialization.data(withJSONObject: model.value, options: .prettyPrinted) {
                    mTextView.text = String(data: jsonData, encoding: .utf8)
                } else {
                    mTextView.text = "\(model.value)"
                }
        }
    }
}

extension String {
    var boolValue: Bool {
        switch self.lowercased() {
            case "false", "no", "0":
                return false
            default:
                return !self.isEmpty
        }
    }
}
