//
//  ViewController.swift
//  IOSChallenge
//
//  Created by 전성훈 on 2023/03/01.
//

import UIKit

import SnapKit

final class ViewController: UIViewController {
    private lazy var presenter = ViewPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(TableViewFooterView.self, forHeaderFooterViewReuseIdentifier: TableViewFooterView.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension ViewController: ViewProtocol {
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
