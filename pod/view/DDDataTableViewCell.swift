//
//  DDDataTableViewCell.swift
//  DDUserDefaultManager
//
//  Created by Damon on 2021/7/15.
//

import UIKit

class DDDataTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self._createUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    lazy var mIconButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(UIColor.dd.color(hexValue: 0xffffff), for: .normal)
        button.backgroundColor = UIColor.dd.color(hexValue: 0x93D9A3)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()

    lazy var mTitleLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.lineBreakMode = .byCharWrapping
        tLabel.numberOfLines = 3
        tLabel.font = .systemFont(ofSize: 12)
        tLabel.textColor = UIColor.dd.color(hexValue: 0x333333)
        return tLabel
    }()
}

extension DDDataTableViewCell {
    func updateUI(model: DDDataCellModel) {
        self._updateButton(model: model)

        let attributedString = NSMutableAttributedString(string: "Key: \(model.key)\n\n")
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor : UIColor.dd.color(hexValue: 0xFF616D), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)], range: NSRange(location: 0, length: 4))
        
        var value = "\(model.value)"
        if model.value is Bool {
            value = (model.value as! Bool) ? "true" : "false"
        }
        let valueAttributedString = NSMutableAttributedString(string: "Value: \(value)")
        valueAttributedString.setAttributes([NSAttributedString.Key.foregroundColor : UIColor.dd.color(hexValue: 0x5D8233), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)], range: NSRange(location: 0, length: 7))
        attributedString.append(valueAttributedString)
        mTitleLabel.attributedText = attributedString
    }
}

extension DDDataTableViewCell {
    func _createUI() {
        self.contentView.addSubview(mIconButton)
        mIconButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        mIconButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        mIconButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        mIconButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

        self.contentView.addSubview(mTitleLabel)
        
        mTitleLabel.leftAnchor.constraint(equalTo: self.mIconButton.rightAnchor, constant: 10).isActive = true
        mTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        mTitleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        mTitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20).isActive = true
    }

    func _updateButton(model: DDDataCellModel) {
        if model.value is Bool {
            mIconButton.backgroundColor = UIColor.dd.color(hexValue: 0xA03C78)
            mIconButton.setTitle("Bool", for: .normal)
        } else if model.value is NSNumber {
            mIconButton.backgroundColor = UIColor.dd.color(hexValue: 0xED8E7C)
            mIconButton.setTitle("Number", for: .normal)
        } else if model.value is String {
            mIconButton.backgroundColor = UIColor.dd.color(hexValue: 0x96BAFF)
            mIconButton.setTitle("String", for: .normal)
        } else if model.value is NSArray {
            mIconButton.backgroundColor = UIColor.dd.color(hexValue: 0x7C83FD)
            mIconButton.setTitle("Array", for: .normal)
        } else if model.value is NSDictionary {
            mIconButton.backgroundColor = UIColor.dd.color(hexValue: 0x88FFF7)
            mIconButton.setTitle("Dictionary", for: .normal)
        } else {
            mIconButton.setTitle("\(type(of: model.value))", for: .normal)
        }
    }
}
