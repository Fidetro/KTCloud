//
//  PasteButton.swift
//  KTPasteBoard
//
//  Created by Fidetro on 2018/12/17.
//  Copyright © 2018 karim. All rights reserved.
//

import UIKit
import SnapKit

class PasteButton: UIControl {

    enum Status {
        case normal
        case selected
        case success
        case failure
    }
    
    lazy var backgroundImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.isUserInteractionEnabled = false
        imgView.image = UIImage.init(named: "widget_button_bg")
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        snpLayoutSubivew()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStatus(_ status:Status) {
        switch status {
        case .normal:
            isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1
            }
        case .selected:
            isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.1) {
                self.alpha = 0.5
            }
        case .success:
            isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1
            }
        case .failure:
            isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1
            }
        }
    }
    
    func snpLayoutSubivew() {
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        backgroundImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

}
