//
//  DetailViewController.swift
//  SNInterview
//
//  Created by Vignesh Radhakrishnan on 06/05/22.
//  Copyright © 2022 ServiceNow. All rights reserved.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController, CentralSpinnerProtocol {
    var centralSpinner: UIActivityIndicatorView?
    private let viewModel: DetailViewModel
    private var tableView = UITableView()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Coffee Reviews"
        initCenterSpinner()
        setupTableView()
        fetchDetails()
    }
    
    private func fetchDetails() {
        animateCentralSpinner()
        viewModel.fetchDetails { [weak self] result in
            DispatchQueue.main.async {
                self?.stopAnimatingCentralSpinner()
                switch result {
                case .success(_):
                    self?.tableView.reloadData()
                case .failure(_):
                    // Show alert or toast
                    break
                }
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
        
        tableView.register(UINib(nibName: String(describing: CoffeeShopCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CoffeeShopCell.self))
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoffeeShopCell.self), for: indexPath)
        if let cell = cell as? CoffeeShopCell, let model = self.viewModel.getCellViewModel(atIndex:  indexPath.row) {
            cell.configureData(coffeeShop: model)
        }
        return cell
    }
}
