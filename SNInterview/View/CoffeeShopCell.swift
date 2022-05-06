//
//  CoffeeShopCell.swift
//  SNInterview
//
//  Created by Vignesh Radhakrishnan on 06/05/22.
//  Copyright © 2022 ServiceNow. All rights reserved.
//

import Foundation
import UIKit

final class CoffeeShopCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension CoffeeShopCell {
    func configureData(coffeeShop: CoffeeShop) {
        nameLabel.text = coffeeShop.name
        reviewLabel.text = coffeeShop.review
        ratingLabel.text = "Rating: \(Int(coffeeShop.rating))"
    }
}
