//
//  HistoryInteractor.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 21.11.2022.
//

import Foundation

protocol HistoryInteractorProtocol: AnyObject {
    func loadAnime()
    func loadAnimeFact(with indexPath: IndexPath)
    func loadAnime(containing searchString: String)
    var anime: [HistoryEntity] { get }
}

class HistoryInteractor: HistoryInteractorProtocol {
    weak var presenter: HistoryPresenterProtocol?
    let animeFetchService: CoreDataManager?
    
    var anime: [HistoryEntity] = []
    
    init(animeFetchService: CoreDataManager) {
        self.animeFetchService = animeFetchService
    }
    
    func loadAnime() {
        animeFetchService!.fetchAnime { [weak self] anime in
            var sortedAnimeFacts = anime
            for iterator in 0..<anime.count {
                sortedAnimeFacts[iterator].animeFacts = anime[iterator].animeFacts.sorted { $0.factId < $1.factId }
            }
            self?.presenter?.didLoadAnime(anime: sortedAnimeFacts)
            self?.anime = sortedAnimeFacts
        }
    }
    
    func loadAnimeFact(with indexPath: IndexPath) {
        let fact = anime[indexPath.section].animeFacts[indexPath.row]
        presenter?.didLoadAnimeFact(animeFact: DetailsAnimeFact(fact: fact.fact, factId: fact.factId))
    }
    
    func loadAnime(containing searchString: String) {
        let specifiedAnime = anime.filter { $0.name.contains(searchString) }
        presenter?.didLoadAnime(anime: specifiedAnime)
    }
    
}
