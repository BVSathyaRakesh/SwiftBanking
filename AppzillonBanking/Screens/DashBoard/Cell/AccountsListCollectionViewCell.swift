//
//  AccountsListCollectionViewCell.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/22.
//

import UIKit

class AccountsListCollectionViewCell: UICollectionViewCell {
    
    static func getSize() -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    static let identifier = "AccountsListCollectionViewCell"
    
    private let bgView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#22214F")
        view.clipsToBounds = true
        view.layer.cornerRadius = 8.0
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private  let accNoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center;
        return label
    }()
    
    private  let accNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center;
        return label
    }()
    private  let accTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center;
        return label
    }()
    private  let avlBalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center;
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.frame = CGRect(x: 10, y: 10, width: contentView.width-10, height: contentView.height - 10)
        
        accNameLabel.frame = CGRect(x: 10,
                                    y: bgView.frame.origin.y + 80,
                                    width: contentView.width - 50,
                                    height: 30)
        
        accNoLabel.frame = CGRect(x: 10,
                                  y: accNameLabel.bottom ,
                                  width: contentView.width - 50,
                                  height: 30)
        
        avlBalLabel.frame = CGRect(x: 10,
                                   y: accNoLabel.bottom ,
                                   width: contentView.width - 50,
                                   height: 30)
        
        accTypeLabel.frame = CGRect(x: 10,
                                    y: avlBalLabel.bottom ,
                                    width: contentView.width - 50,
                                    height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accNameLabel.text = nil
        accNoLabel.text = nil
        avlBalLabel.text = nil
        accTypeLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(bgView)
        bgView.addSubview(accNameLabel)
        bgView.addSubview(accNoLabel)
        bgView.addSubview(avlBalLabel)
        bgView.addSubview(accTypeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with accName:String, accNo:String, avlBal:String,accType:String){
        accNameLabel.text = accName
        accNoLabel.text = accNo
        avlBalLabel.text = avlBal
        accTypeLabel.text = "Account Type: \(accType)"
    }
    
    
}
