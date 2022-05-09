//
//  DetailService.swift
//  SNInterview
//
//  Created by Vignesh Radhakrishnan on 07/05/22.
//  Copyright © 2022 ServiceNow. All rights reserved.
//

import Foundation

protocol DetailServiceRepresentable {
    func fetchDetails(completion: @escaping ((Result<[CoffeeShop], Error>) -> Void))
}

struct DetailService: DetailServiceRepresentable {

    func fetchDetails(completion: @escaping ((Result<[CoffeeShop], Error>) -> Void)) {
        if let data = readLocalFile(forName: "CoffeeShops") {
            do {
                let models = try JSONDecoder().decode([CoffeeShop].self, from: data)
                completion(.success(models))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "Could not load json", code: 0, userInfo: nil)))
        }
        
    }

    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}

struct MockDetailService: DetailServiceRepresentable {

    var error: Error?

    init(error: Error? = nil) {
        self.error = error
    }

    func fetchDetails(completion: @escaping ((Result<[CoffeeShop], Error>) -> Void)) {
        if let error = error {
            completion(.failure(error))
        } else {
            let model1 = CoffeeShop(name: "test", review: "test", rating: 1)
            let model2 = CoffeeShop(name: "test", review: "test", rating: 1)

            completion(.success([model1,model2]))
        }
    }
}
