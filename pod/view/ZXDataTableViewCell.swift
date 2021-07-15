//
//  ZXDataTableViewCell.swift
//  ZXUserDefaultManager
//
//  Created by Damon on 2021/7/15.
//

import UIKit

class ZXDataTableViewCell: UITableViewCell {

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
        return button
    }()

    lazy var mTitleLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.font = .systemFont(ofSize: 14)
        tLabel.textColor = UIColor.zx.color(hexValue: 0x333333)
        return tLabel
    }()
}

extension ZXDataTableViewCell {
    func _createUI() {
        self.contentView.addSubview(mIconButton)
        mIconButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }

        self.contentView.addSubview(mTitleLabel)
        mTitleLabel.snp.makeConstraints {
            $0.left.equalTo(mIconButton.snp.right).offset(10)
            $0.top.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-20)
        }
    }
}
