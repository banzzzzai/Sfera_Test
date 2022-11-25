//
//  ViewController.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 20.11.2022.
//

import UIKit
import SnapKit

protocol SearchFactsViewProtocol: AnyObject {
    func showAnimeFacts(animeFacts: SearchFactsEntity?)
}

class SearchFactsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchFactsTableViewCell.self, forCellReuseIdentifier: SearchFactsTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: SearchFactsPresenterProtocol?
    var animeFacts: SearchFactsEntity? {
        willSet {
            animeName = searchController.searchBar.text!.lowercased()
        }
    }
    var animeName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    private func setUp() {
        view.backgroundColor = .secondarySystemBackground
        title = "Search"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupSearchController()
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
    }
    
    //MARK: - SetupSearchController
    private func setupSearchController() {
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search facts by anime name"
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        
    }
    
}

extension SearchFactsViewController: SearchFactsViewProtocol {
    func showAnimeFacts(animeFacts: SearchFactsEntity?) {
        guard let animeFacts = animeFacts else { return }
        self.animeFacts = animeFacts
        self.tableView.reloadData()
    }
    
}

extension SearchFactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchFactsTableViewCell.identifier) as? SearchFactsTableViewCell, let animeFacts = animeFacts else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        cell.nameLabel.text = "\(animeName?.capitalized ?? "Anime") - Fact №\(animeFacts.data[indexPath.row].fact_id)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animeFacts?.total_facts ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapAnimeFactCell(with: indexPath, animeName: animeName!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchFactsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
            .components(separatedBy: " ")
            .filter { !$0.isEmpty }
            .joined(separator: "_")
            .lowercased()
        
        presenter?.startSearchAnimeFacts(for: searchString)
    }
    
}
