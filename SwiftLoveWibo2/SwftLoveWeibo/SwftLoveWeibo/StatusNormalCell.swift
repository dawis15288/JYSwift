//
//  StatusNormalCell.swift
//  SwftLoveWeibo
//
//  Created by atom on 16/3/18.
//  Copyright © 2016年 cyin. All rights reserved.
//

import UIKit

class StatusNormalCell: StatusTableViewCell {

    override func setupUIs() {
        
        super.setupUIs()
        
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        
        pictureWidthCons = pictureView.xmg_Constraint(cons, attribute: .Width)
        
        pictrueHeightCons = pictureView.xmg_Constraint(cons, attribute: .Height)
        
    }

}
