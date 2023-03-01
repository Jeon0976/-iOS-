//
//  ViewPresenter.swift
//  IOSChallenge
//
//  Created by 전성훈 on 2023/03/01.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func setupView()
    func didTapLoadButton(sender: UIButton)
}

final class ViewPresenter: NSObject {
    private weak var viewController: ViewProtocol?
    
    init(viewController: ViewProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
    }
    
    @objc func didTapLoadButton(sender: UIButton) {
        viewController?.didTapLoadButton(sender: sender)
    }
}

extension ViewPresenter: UITableViewDelegate {
    
}

extension ViewPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.identifier,
            for: indexPath
        ) as? TableViewCell
        
        cell?.setup()
        cell?.loadButton.tag = indexPath.row
        cell?.loadButton.addTarget(self, action: #selector(didTapLoadButton(sender: )), for: .touchUpInside)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TableViewFooterView.identifier
        ) as? TableViewFooterView
        
        footer?.setup()
        
        return footer ?? UITableViewHeaderFooterView()
    }
}
