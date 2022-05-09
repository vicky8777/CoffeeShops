//
//  DetailViewModel.swift
//  SNInterview
//
//  Created by Vignesh Radhakrishnan on 06/05/22.
//  Copyright © 2022 ServiceNow. All rights reserved.
//

import Foundation

final class DetailViewModel {

    private let service: DetailServiceRepresentable
    private var models: [CoffeeShop] = []

    init(service: DetailServiceRepresentable) {
        self.service = service
    }

    func fetchDetails(completion: @escaping (Result<Bool, Error>) -> Void) {
        service.fetchDetails { [weak self] result in
            switch result {
            case let .success(models):
                self?.models = models
                completion(.success(true))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func numberOfItems() -> Int {
        return models.count
    }

    func getCellViewModel(atIndex index:Int) -> CoffeeShop? {
        guard index < models.count else {
            return nil
        }
        return models[index]
    }
}
