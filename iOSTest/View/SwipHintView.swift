//
//  SwipHintView.swift
//  iOSTest
//
//  Created by Wuxi on 2017/12/18.
//  Copyright © 2017年 Wuxi. All rights reserved.
//

import UIKit
import SnapKit

class SwipHintView: UIVisualEffectView {

    var hintImage : UIImage
    var hintText : String
    
    fileprivate let hintImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    fileprivate let hintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    init(hintImage: UIImage, hintText: String) {
        self.hintImage = hintImage
        self.hintText = hintText
        super.init(effect: UIBlurEffect(style: .dark))
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.hintImageView.image = self.hintImage
        self.hintLabel.text = self.hintText
        contentView.addSubview(hintImageView)
        contentView.addSubview(hintLabel)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        hintLabel.snp.makeConstraints { [unowned self](make) in
            make.left.equalTo(self.contentView).offset(16)
            make.right.equalTo(self.contentView).offset(-16)
            make.bottom.equalTo(self.contentView).offset(-24)
            make.height.equalTo(40)
        }
        hintImageView.snp.makeConstraints { [unowned self](make) in
            make.top.left.equalTo(self.contentView).offset(16)
            make.right.equalTo(self.contentView).offset(-16)
            make.bottom.equalTo(hintLabel.snp.top).offset(-8)
        }
    }
}
