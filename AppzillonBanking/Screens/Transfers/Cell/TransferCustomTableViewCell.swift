//
//  TransferCustomTableViewCell.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/28.
//

import UIKit

class TransferCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var accNameLabel: UILabel!
    
    @IBOutlet weak var accNoLabel: UILabel!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
