//
//  HeadingImageCollectionViewCell.swift
//  iOSJanAssignment
//
//  Created by Mounika Ankeswarapu on 24/01/25.
//

import UIKit

class HeadingImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var headingImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        headingImg.clipsToBounds = true
        
        headingImg.layer.cornerRadius = 15
        headingImg.layer.masksToBounds = false
    }
    
    override func prepareForReuse() {
        self.headingImg.image = nil
    }

}
