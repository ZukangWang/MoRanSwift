//
//  GBMCommentListCell.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/8.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import UIKit

class GBMCommentListCell: UITableViewCell {
    
    @IBOutlet weak var commentLabel:UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
