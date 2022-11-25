//
//  SearchFactsPresenter.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 20.11.2022.
//

import Foundation

protocol SearchFactsPresenterProtocol: AnyObject {
    func startSearchAnimeFacts(for animeName: String)
    func didLoadAnimeFacts(animeFacts: SearchFactsEntity?)
    func didTapAnimeFactCell(with indexPath: IndexPath, animeName: String)
    func startSavingToCoreData(animeName: String, animeFact: AnimeFact)
}

class SearchFactsPresenter {
    weak var view: SearchFactsViewProtocol?
    var router: SearchFactsRouterProtocol?
    var interactor: SearchFactsInteractorProtocol?
    
    init(router: SearchFactsRouterProtocol, interactor: SearchFactsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension SearchFactsPresenter: SearchFactsPresenterProtocol {
    func startSearchAnimeFacts(for animeName: String) {
        interactor?.loadAnimeFacts(for: animeName)
    }
    
    func didLoadAnimeFacts(animeFacts: SearchFactsEntity?) {
        view?.showAnimeFacts(animeFacts: animeFacts)
    }
    
    func didTapAnimeFactCell(with indexPath: IndexPath, animeName: String) {
        guard let animeFact = interactor?.loadAnimeFact(with: indexPath) else { return }
        router?.openAnimeFact(for: animeFact)
        let fact = AnimeFact(fact_id: animeFact.factId, fact: animeFact.fact)
        startSavingToCoreData(animeName: animeName, animeFact: fact)
    }
    
    func startSavingToCoreData(animeName: String, animeFact: AnimeFact) {
        interactor?.saveToCoreData(animeName: animeName, animeFact: animeFact)
    }
    
}
