//
//  ProductTableViewCell.swift
//  07_08_2023_WebServicesDemo2
//
//  Created by Vishal Jagtap on 17/10/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
