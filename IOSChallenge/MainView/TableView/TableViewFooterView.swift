//
//  TableViewFooterView.swift
//  IOSChallenge
//
//  Created by 전성훈 on 2023/03/01.
//

import UIKit

import SnapKit

final class TableViewFooterView: UITableViewHeaderFooterView {
    static let identifier = "TableViewFooterView"
    
    private lazy var loadAllButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("Load All Images", for: .normal)
        button.configuration = .filled()
        
        return button
    }()
    
    func setup() {
        setupLayout()
    }
}

private extension TableViewFooterView {
    func setupLayout() {
        addSubview(loadAllButton)
        
        let inset: CGFloat = 16.0
        
        loadAllButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.top.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
        }
    }
}
