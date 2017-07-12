//
//  RiskCell.swift
//  Teambrella
//
//  Created by Екатерина Рыжова on 11.07.17.
//  Copyright © 2017 Yaroslav Pasternak. All rights reserved.
//

import UIKit

class RiskCell: UICollectionViewCell, XIBInitableCell {
    @IBOutlet var avatar: RoundImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var riskLabel: UILabel!
    @IBOutlet var forwardView: UIImageView!
    @IBOutlet var cellSeparator: UIView!
    @IBOutlet var cellSeparatorLeading: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        CellDecorator.shadow(for: self)
    }

}