//
//  CollectionViewCell.swift
//  InstaAuth
//
//  Created by Lawrence Holmes on 01/04/2017.
//  Copyright © 2017 David Seek. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  var imageView: UIImageView!
  
  override func awakeFromNib() {
    
    // Setup Image
    let padding = contentView.frame.width * 0.05
    let size = contentView.frame.width * 0.9
    imageView = UIImageView(frame: CGRect(x: padding, y: padding, width: size, height: size))
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    
    contentView.addSubview(imageView)
  }
}
