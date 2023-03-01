//
//  TableViewFooterView.swift
//  IOSChallenge
//
//  Created by 전성훈 on 2023/03/01.
//

import UIKit

import SnapKit

protocol TableViewFooterViewDelegate: AnyObject {
   func didSelectAllLoad()
}

final class TableViewFooterView: UITableViewHeaderFooterView {
    static let identifier = "TableViewFooterView"
    
    /// button action 외부 실행을 위한 delegate 생성
    private weak var delegate: TableViewFooterViewDelegate?
    
    private lazy var loadAllButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("Load All Images", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(didTapLoadAllButton), for: .touchUpInside)
        
        return button
    }()
    
    func setup(delegate: TableViewFooterViewDelegate) {
        self.delegate = delegate
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
    
    @objc func didTapLoadAllButton() {
        delegate?.didSelectAllLoad()
    }
}
