//
//  SearchFactsInteractor.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 20.11.2022.
//

import Foundation

protocol SearchFactsInteractorProtocol: AnyObject {
    func loadAnimeFacts(for animeName: String)
    var animeFacts: SearchFactsEntity { get }
    func loadAnimeFact(with indexPath: IndexPath) -> DetailsAnimeFact
    func saveToCoreData(animeName: String, animeFact: AnimeFact)
}

class SearchFactsInteractor: SearchFactsInteractorProtocol {
    weak var presenter: SearchFactsPresenterProtocol?
    let animeFactsService: AnimeFactsService?
    
    var animeFacts: SearchFactsEntity = SearchFactsEntity(img: "", total_facts: 0, data: [])
    
    init(animeFactsService: AnimeFactsService) {
        self.animeFactsService = animeFactsService
    }
    
    func loadAnimeFacts(for animeName: String) {
        animeFactsService!.getFactsAbout(animeName: animeName) { [weak self] animeFacts in
            self?.presenter?.didLoadAnimeFacts(animeFacts: animeFacts)
            self?.animeFacts = animeFacts
        }
    }
    
    func loadAnimeFact(with indexPath: IndexPath) -> DetailsAnimeFact {
        let fact = animeFacts.data[indexPath.row]
        return DetailsAnimeFact(fact: fact.fact, factId: fact.fact_id)
    }
    
    func saveToCoreData(animeName: String, animeFact: AnimeFact) {
        CoreDataManager.shared.saveToCoreData(animeName: animeName, animeFact: animeFact)
    }
    
}
