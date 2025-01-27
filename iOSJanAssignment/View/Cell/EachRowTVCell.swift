//
//  EachRowTVCell.swift
//  iOSJanAssignment
//
//  Created by Mounika Ankeswarapu on 25/01/25.
//

import UIKit

class EachRowTVCell: UITableViewCell {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var typeNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        typeImageView.layer.cornerRadius = typeImageView.frame.height / 2
        typeImageView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
