//
//  ViewPresenter.swift
//  IOSChallenge
//
//  Created by 전성훈 on 2023/03/01.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func setupView()
    func reloadTableView()
}

final class ViewPresenter: NSObject {
    private weak var viewController: ViewProtocol?
    
    /// 최초 progress 진행상태
    private var progress: Float = 0.1
    
    /// Load All Images 버튼 클릭이 되었는지 확인 변수
    private var allButton: Bool = false
    
    private let imageModel: [ImageModel] = [
        ImageModel(url: URL(string: "https://picsum.photos/100/100")!),
        ImageModel(url: URL(string: "https://picsum.photos/100/100")!),
        ImageModel(url: URL(string: "https://picsum.photos/100/100")!),
        ImageModel(url: URL(string: "https://picsum.photos/100/100")!),
        ImageModel(url: URL(string: "https://picsum.photos/100/100")!)
    ]

    init(viewController: ViewProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
    }
}

extension ViewPresenter: TableViewFooterViewDelegate {
    /// Load All Images 버튼 클릭시 각 cell 초기화 후, Button 기능 실행
    func didSelectAllLoad() {
        viewController?.reloadTableView()
        allButton = true
        viewController?.reloadTableView()
    }
}

extension ViewPresenter: UITableViewDelegate {
}

extension ViewPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.identifier,
            for: indexPath
        ) as? TableViewCell
        
        let image = imageModel[indexPath.row]
        
        cell?.setup(imageModel: image, progress: progress, allButton: allButton)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TableViewFooterView.identifier
        ) as? TableViewFooterView
        
        footer?.setup(delegate: self)
        
        return footer ?? UITableViewHeaderFooterView()
    }
}
