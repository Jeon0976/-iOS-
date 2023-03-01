//
//  TableViewCell.swift
//  IOSChallenge
//
//  Created by 전성훈 on 2023/03/01.
//

import UIKit

import SnapKit
import Kingfisher

final class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    private var imageModel: ImageModel?
    
    /// progress bar 진행을 위한 time, timer 변수
    private var time: Float = 0.1
    private var timer: Timer?
    
    /// UIImageView에 반영할 최초 이미지
    private var photoImage: UIImage = {
        var image = UIImage()
        
        var config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 71.0))
        image = UIImage(systemName: "photo", withConfiguration: config)!
        
        return image
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
                
        imageView.image = photoImage
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        
        progressBar.progressViewStyle = .default
        progressBar.trackTintColor = .lightGray
        progressBar.progressTintColor = .systemBlue
        
        return progressBar
    }()
    
    private lazy var loadButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("Load", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(didTapLoadButton), for: .touchUpInside)
        
        return button
    }()
    
    func setup(imageModel: ImageModel, progress: Float, allButton: Bool) {
        setupLayout()
        
        self.imageModel = imageModel
        image.image = photoImage
        progressBar.progress = progress
        
        selectionStyle = .none
        
        /// Load All Images 버튼이 클릭되었을 시 실행
        if allButton == true {
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                timeInterval: 0.01,
                target: self,
                selector: #selector(setProgress),
                userInfo: nil,
                repeats: true)
        }
    }
}

private extension TableViewCell {
    func setupLayout() {
        [image, progressBar, loadButton]
            .forEach { contentView.addSubview($0) }
            
        let inset: CGFloat = 16.0
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
        }
        
        progressBar.snp.makeConstraints {
            $0.centerY.equalTo(image.snp.centerY)
            $0.leading.equalTo(image.snp.trailing).offset(inset)
        }
        
        loadButton.snp.makeConstraints {
            $0.centerY.equalTo(image.snp.centerY)
            $0.leading.equalTo(progressBar.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
    }
    
    @objc func didTapLoadButton() {
        if time >= 1.0 {
            progressBar.progress = 0.1
            image.image = photoImage
            time = 0.0
        } else {
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                timeInterval: 0.05,
                target: self,
                selector: #selector(setProgress),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    @objc func setProgress() {
        time += 0.1
        progressBar.setProgress(time, animated: true)
        if time >= 1.0 {
            timer?.invalidate()
            let imageURL = imageModel?.url
            image.kf.setImage(with: imageURL)
        }
    }
}
