//
//  HistoryViewController.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 20.11.2022.
//

import UIKit
import SwiftUI

protocol HistoryViewProtocol: AnyObject {
    func showAnime(anime: [HistoryEntity]?)
}

class HistoryViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: HistoryPresenterProtocol?
    var allAnime: [HistoryEntity]?{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if searchController.searchBar.text! == "" {
            presenter?.startDisplayAllAnime()
        }
    }
    
    private func setUp() {
        view.backgroundColor = .secondarySystemBackground
        title = "History"
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

extension HistoryViewController: HistoryViewProtocol {
    func showAnime(anime: [HistoryEntity]?) {
        guard let anime = anime else { return }
        self.allAnime = anime
    }
    
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allAnime?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier) as? HistoryTableViewCell, let allAnime = allAnime else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        cell.nameLabel.text = "Fact №\(allAnime[indexPath.section].animeFacts[indexPath.row].factId)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let allAnime = allAnime {
            let section = allAnime[section]
            return section.name
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let allAnime = allAnime else { return 0 }
        return allAnime[section].animeFacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapAnimeFactCell(with: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        let degree: Double = 90
//        let rotationAngle = CGFloat(degree * Double.pi / 180)
//        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 0, 1, 0)
//        cell.layer.transform = rotationTransform
//
//        UIView.animate(withDuration: 0.4, delay: 0.1 * Double(indexPath.row), options: .curveEaseInOut, animations: {
//            cell.layer.transform = CATransform3DIdentity
//        })
        
        let translationTransform = CATransform3DTranslate(CATransform3DIdentity, 500, 0, 0)
        cell.layer.transform = translationTransform
        
        UIView.animate(withDuration: 0.4, delay: 0.1 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
        
    }
    
}

extension HistoryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            presenter?.startDisplayAllAnime()
            return
        }
        let searchString = searchController.searchBar.text!
            .components(separatedBy: " ")
            .filter { !$0.isEmpty }
            .joined(separator: " ")
            .lowercased()
        presenter?.startDisplayAnime(containing: searchString)
    }
    
}
