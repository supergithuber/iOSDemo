//
//  WXBlurNavigationBar.swift
//  iOSDemo
//
//  Created by Wuxi on 2018/4/10.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

import UIKit

class WXBlurNavigationBar: UIVisualEffectView {

    open var title:String?
    open var leftImage:String?
    open var leftTitle:String?
    
    open var rightImage:String?
    open var rightTitle:String?
    
    open var leftBlock: (() -> Void)?
    open var rightBlock: (() -> Void)?
    
    fileprivate let titleLabel : UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    fileprivate let leftButton : UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    fileprivate let rightButton : UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    fileprivate let lineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    convenience init(frame:CGRect, effect:UIVisualEffect?){
        self.init(effect: effect)
        self.frame = frame
    }
    open func setRightImage(image:String, rightBlock:(() -> Void)?){
        rightButton.setImage(UIImage.init(named: image), for: .normal)
        self.rightBlock = rightBlock
    }
    open func setLeftImage(image:String, leftBlock:(() -> Void)?){
        leftButton.setImage(UIImage.init(named: image), for: .normal)
        self.leftBlock = leftBlock
    }
    open func setLeftTitle(title:String, leftBlock:(() -> Void)?){
        leftButton.setTitle(title, for: .normal)
        self.leftBlock = leftBlock
    }
    open func setRightTitle(title:String, rightBlock:(() -> Void)?){
        rightButton.setTitle(title, for: .normal)
        self.rightBlock = rightBlock
    }
    fileprivate func commonSetup(){
        contentView.addSubview(leftButton)
        contentView.addSubview(rightButton)
        contentView.addSubview(lineView)
        contentView.addSubview(titleLabel)
        leftButton.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
        setupConstraints()
    }
    fileprivate func setupConstraints(){
        titleLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 270, height: 44))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        leftButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        rightButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        lineView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.left.equalToSuperview()
        }
    }
    @objc fileprivate func leftClick(){
        leftBlock?()
    }
    @objc fileprivate func rightClick(){
        rightBlock?()
    }
}
