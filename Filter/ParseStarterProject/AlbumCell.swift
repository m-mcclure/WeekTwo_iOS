//
//  AlbumCell.swift
//  Filter
//
//  Created by Matthew McClure on 8/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
  
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet weak var albumPhoto: UIImageView!

  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
