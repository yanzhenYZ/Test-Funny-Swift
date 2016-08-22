//
//  SinaPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/1/5.
//  Copyright (c) 2016年 yanzhen. All rights reserved.
//

import UIKit

class SinaPictureTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var onlyImageView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var model: SinaNewsModel! {
        didSet{
            titleLab.text = model.title;
            subTitleLabel.text = model.intro;
            
            onlyImageView.sd_setImageWithURL(NSURL(string: model.kpic), placeholderImage: SmallImage);
        }
    }
}
