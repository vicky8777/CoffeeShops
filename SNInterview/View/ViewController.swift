//
//  ViewController.swift
//  SNInterview
//
//  Copyright © 2019 ServiceNow. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private let viewModel: CoffeeShopsViewModel
    private var tableView = UITableView()

    init(viewModel: CoffeeShopsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Coffee Shops"
        setupTableView()
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
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoffeeShopCell.self), for: indexPath)
        if let cell = cell as? CoffeeShopCell {
            cell.configureData(coffeeShop: self.viewModel.getCellViewModel(atIndex:  indexPath.row))
        }
        return cell
    }
}
