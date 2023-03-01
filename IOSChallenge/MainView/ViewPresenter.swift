//
//  ViewPresenter.swift
//  IOSChallenge
//
//  Created by 전성훈 on 2023/03/01.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func setupView()
}

final class ViewPresenter: NSObject {
    private weak var viewController: ViewProtocol?
    
    init(viewController: ViewProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupView()
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
