//
//  HomeApplicationDeniedCell.swift
//  Teambrella
//
//  Created by Екатерина Рыжова on 07.07.17.

/* Copyright(C) 2017  Teambrella, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License(version 3) as published
 * by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see<http://www.gnu.org/licenses/>.
 */

import UIKit

class HomeApplicationDeniedCell: UICollectionViewCell, XIBInitableCell, ClosableCell {
    @IBOutlet var backView: RadarView!
    @IBOutlet var avatar: RoundImageView!
    @IBOutlet var yummigum: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var centerLabel: UILabel!
    @IBOutlet var button: BorderedButton!
    
    var closeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewDecorator.roundedEdges(for: self)
        ViewDecorator.shadow(for: self)
//        ViewDecorator.addCloseButton(for: self)
    }
}
