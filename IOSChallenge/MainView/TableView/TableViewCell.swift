//
//  TableViewCell.swift
//  IOSChallenge
//
//  Created by 전성훈 on 2023/03/01.
//

import UIKit

import SnapKit

final class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 80.0))
        let photoImage = UIImage(systemName: "photo", withConfiguration: config)
        
        imageView.image = photoImage
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        
        progressBar.progressViewStyle = .default
        progressBar.trackTintColor = .lightGray
        progressBar.progressTintColor = .systemBlue
        progressBar.progress = 0.1
        
        return progressBar
    }()
    
    private lazy var loadButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("Load", for: .normal)
        button.configuration = .filled()
        
        return button
    }()
    
    func setup() {
        setupLayout()
        
        selectionStyle = .none
    }
}

private extension TableViewCell {
    func setupLayout() {
        [image, progressBar, loadButton]
            .forEach { addSubview($0) }
        
        let inset: CGFloat = 16.0
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
        }
        
        progressBar.snp.makeConstraints {
            $0.centerY.equalTo(image.snp.centerY)
            $0.leading.equalTo(image.snp.trailing)
        }
        
        loadButton.snp.makeConstraints {
            $0.centerY.equalTo(image.snp.centerY)
            $0.leading.equalTo(progressBar.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
    }
}
