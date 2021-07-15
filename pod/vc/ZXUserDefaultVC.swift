//
//  ZXUserDefaultVC.swift
//  ZXUserDefaultManager
//
//  Created by Damon on 2021/7/15.
//

import UIKit

func UIImageHDBoundle(named: String?) -> UIImage? {
    guard let name = named else { return nil }
    guard let bundlePath = Bundle(for: ZXUserDefaultManager.self).path(forResource: "ZXUserDefaultManager", ofType: "bundle") else { return UIImage(named: name) }
    guard let bundle = Bundle(path: bundlePath) else { return UIImage(named: name) }
    return UIImage(named: name, in: bundle, compatibleWith: nil)
}

extension String{
    var ZXLocaleString: String {
        guard let bundlePath = Bundle(for: ZXUserDefaultManager.self).path(forResource: "ZXUserDefaultManager", ofType: "bundle") else { return NSLocalizedString(self, comment: "") }
        guard let bundle = Bundle(path: bundlePath) else { return NSLocalizedString(self, comment: "") }
        let msg = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        return msg
    }
}

class ZXUserDefaultVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarItem = UIBarButtonItem(title: "close".ZXLocaleString, style: .plain, target: self, action: #selector(_rightBarItemClick))
        self.navigationItem.rightBarButtonItem = rightBarItem

        self._createUI()
        self._loadData()
    }

    @objc func _rightBarItemClick() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func _leftBarItemClick() {

        self._loadData()
    }

    lazy var mTableView: UITableView = {
        let tTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        tTableView.rowHeight = 60
        tTableView.estimatedRowHeight = 60
        tTableView.backgroundColor = UIColor.clear
        tTableView.showsVerticalScrollIndicator = false
        tTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tTableView.dataSource = self
        tTableView.delegate = self
        tTableView.register(ZXDataTableViewCell.self, forCellReuseIdentifier: "ZXDataTableViewCell")
        return tTableView
    }()
}

extension ZXUserDefaultVC {
    func _createUI() {
        self.view.backgroundColor = UIColor.zx.color(hexValue: 0xffffff)
        self.view.addSubview(mTableView)
        mTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func _loadData() {
        UserDefaults.standard.dictionaryRepresentation()
    }
}

extension ZXUserDefaultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mTableViewList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.mTableViewList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZXDataTableViewCell") as! ZXDataTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if model.fileType == .folder {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }

        cell.updateUI(model: model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.mTableViewList[indexPath.row]
        if model.fileType == .folder {
            extensionDirectoryPath = extensionDirectoryPath + "/" + model.name
            self._loadData()
        } else {
            let rightBarItem = UIBarButtonItem(title: "close".ZXLocaleString, style: .plain, target: self, action: #selector(_rightBarItemClick))
            self.navigationItem.rightBarButtonItem = rightBarItem
            self.operateFilePath = self.currentDirectoryPath.appendingPathComponent(model.name, isDirectory: false)
            //preview
            let previewVC = QLPreviewController()
            previewVC.delegate = self
            previewVC.dataSource = self
            self.navigationController?.pushViewController(previewVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        let model = self.mTableViewList[indexPath.row]
        if model.fileType == .folder {
            self.operateFilePath = self.currentDirectoryPath.appendingPathComponent(model.name, isDirectory: true)
            self._showMore(isDirectory: true)
        } else {
            self.operateFilePath = self.currentDirectoryPath.appendingPathComponent(model.name, isDirectory: false)
            self._showMore(isDirectory: false)
        }

        return true
    }

    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {

    }
}

extension ZXUserDefaultVC: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.operateFilePath! as QLPreviewItem
    }
}
