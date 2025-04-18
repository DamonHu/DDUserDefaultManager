//
//  DDUserDefaultVC.swift
//  DDUserDefaultManager
//
//  Created by Damon on 2021/7/15.
//

import UIKit
import DDUtils

func UIImageHDBoundle(named: String?) -> UIImage? {
    guard let name = named else { return nil }
    guard let bundlePath = Bundle(for: DDUserDefaultManager.self).path(forResource: "DDUserDefaultManager", ofType: "bundle") else { return UIImage(named: name) }
    guard let bundle = Bundle(path: bundlePath) else { return UIImage(named: name) }
    return UIImage(named: name, in: bundle, compatibleWith: nil)
}

extension String{
    var DDLocaleString: String {
        guard let bundlePath = Bundle(for: DDUserDefaultManager.self).path(forResource: "DDUserDefaultManager", ofType: "bundle") else { return NSLocalizedString(self, comment: "") }
        guard let bundle = Bundle(path: bundlePath) else { return NSLocalizedString(self, comment: "") }
        let msg = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        return msg
    }
}

open class DDUserDefaultVC: UIViewController {
    var mTableViewList = [DDDataCellModel]()
    open override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarItem = UIBarButtonItem(title: "close".DDLocaleString, style: .plain, target: self, action: #selector(_rightBarItemClick))
        self.navigationItem.rightBarButtonItem = rightBarItem

        self._createUI()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._loadData()
    }

    @objc func _rightBarItemClick() {
        if self.isBeingPresented {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    @objc func _leftBarItemClick() {
        self._loadData()
    }

    lazy var mTableView: UITableView = {
        let tTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        tTableView.translatesAutoresizingMaskIntoConstraints = false
        tTableView.rowHeight = 60
        tTableView.estimatedRowHeight = 60
        tTableView.backgroundColor = UIColor.clear
        tTableView.showsVerticalScrollIndicator = false
        tTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tTableView.dataSource = self
        tTableView.delegate = self
        tTableView.register(DDDataTableViewCell.self, forCellReuseIdentifier: "DDDataTableViewCell")
        return tTableView
    }()
}

extension DDUserDefaultVC {
    func _createUI() {
        self.view.backgroundColor = UIColor.dd.color(hexValue: 0xffffff)
        self.view.addSubview(mTableView)
        mTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        mTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        mTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    func _loadData() {
        mTableViewList.removeAll()
        for item in UserDefaults.standard.dictionaryRepresentation().keys.sorted() {
            let model = DDDataCellModel()
            model.key = item
            model.value = UserDefaults.standard.object(forKey: item)!
            mTableViewList.append(model)
        }
        mTableView.reloadData()
    }
}

extension DDUserDefaultVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mTableViewList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.mTableViewList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DDDataTableViewCell") as! DDDataTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.updateUI(model: model)
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.mTableViewList[indexPath.row]
        let vc = DDUserDefaultEditVC(model: model)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let model = self.mTableViewList[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "删除") { _, _, complete in
            UserDefaults.standard.removeObject(forKey: model.key)
            UserDefaults.standard.synchronize()
            complete(true)
            self._loadData()
        }

        let edit = UIContextualAction(style: .normal, title: "编辑") { _, _, complete in
            let vc = DDUserDefaultEditVC(model: model)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        edit.backgroundColor = UIColor.dd.color(hexValue: 0x5dae8b)

        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        return config

    }
}
