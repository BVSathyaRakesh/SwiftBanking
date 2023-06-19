//
//  DashBoardCollectionViewCell.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/20.
//

import UIKit

class DashBoardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DashBoardCollectionViewCell"
    
    static func getSize() -> CGSize {
        return CGSize(width: 110, height: 110)
    }

    private  let itemLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center;
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private let itemImageView : UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let size = contentView.frame.width/2.0 - 15
       
        itemImageView.frame = CGRect(x: size,
                                     y: contentView.frame.width/2.0 - 25,
                                             width: 30,
                                             height: 30)
                                       
        itemLabel.frame = CGRect(x: 0,
                                 y: itemImageView.bottom ,
                                 width: contentView.width,
                                   height: 30)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
        itemLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemLabel)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.width/2.0
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func configure(with text:String, imageName: UIImage){
                
        if text == "Accounts" {
            contentView.backgroundColor = UIColor.init(hexString: "#95CAFD")
        }else if text == "Statements" {
            contentView.backgroundColor = UIColor.init(hexString: "#9CCC65")
        }
        else if text == "Transfer" {
            contentView.backgroundColor = UIColor.init(hexString: "#BCAAA4")
        }
        else if text == "Notification" {
            contentView.backgroundColor = UIColor.init(hexString: "#FDA729")
        }
        else if text == "Phone Call" {
            contentView.backgroundColor = UIColor.init(hexString: "#FC5C5C")
        }
        else if text == "Location" {
            contentView.backgroundColor = UIColor.init(hexString: "#81C784")
        }
        itemLabel.text = text
        itemImageView.image = imageName
    }
    
}


