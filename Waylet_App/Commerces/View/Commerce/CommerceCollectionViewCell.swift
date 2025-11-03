//
//  CommerceCollectionViewCell.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 29/10/25.
//

import UIKit

class CommerceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var commerceImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        contentView.layer.masksToBounds = true
        
        commerceImage.image = UIImage(named: "only image")
        commerceImage.layer.cornerRadius = 6
    }
    
}
