//
//  CategoryCollectionViewCell.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 31/10/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
        
    
    private func setupUI() {
        contentView.layer.cornerRadius = 10
        
        contentView.layer.borderWidth = 0.2
        
        contentView.layer.masksToBounds = true
    }

}
