//
//  CoffeeShopsViewModel.swift
//  SNInterview
//
//  Created by Vignesh Radhakrishnan on 06/05/22.
//  Copyright © 2022 ServiceNow. All rights reserved.
//

import Foundation

final class CoffeeShopsViewModel {

    private let reviews = [
        CoffeeShop(name:"Lofty", review: "Knowledgeable staff, stacked menu. Trust the Ethiopian in a pour over if you know your flavors. Will be back for the rest of this menu soon.", rating: 4),
        CoffeeShop(name:"Zumbar", review: "Came to SD for school tour and heading back to the Bay Area after today's final meeting. Was drinking Starbucks the whole trip until my sis recommended this cafe to me. LOVE IT!", rating: 5),
        CoffeeShop(name:"Blue Bottle", review: "The place was empty the afternoon I came in, so I was able to quickly place an order for their version of a New Orleans cold brew. I received my drink right as my credit card order went through.", rating: 3),
        CoffeeShop(name:"Bird Rock", review: "When it comes to environment and ambience, this place is amazing! It has a cute lil look, yet looks a bit modern. It's very eye appealing and I would definitely deem Instagramable.", rating: 3),
        CoffeeShop(name:"Better Buzz Coffee", review: "This coffee shop is really cute. The decor is beautiful, food and coffee is tasty and the service is friendly and quick.", rating: 5)
    ]

    func numberOfItems() ->Int {
        return reviews.count
    }
    func getCellViewModel(atIndex index:Int) -> CoffeeShop {
        return reviews[index]
    }
    
}
