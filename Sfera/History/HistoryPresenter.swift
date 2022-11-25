//
//  HistoryPresenter.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 21.11.2022.
//

import Foundation

protocol HistoryPresenterProtocol: AnyObject {
    func startDisplayAllAnime()
    func didLoadAnime(anime: [HistoryEntity]?)
    func didTapAnimeFactCell(with indexPath: IndexPath)
    func didLoadAnimeFact(animeFact: DetailsAnimeFact?)
    func startDisplayAnime(containing searchString: String)
}

class HistoryPresenter {
    weak var view: HistoryViewProtocol?
    var router: HistoryRouterProtocol?
    var interactor: HistoryInteractorProtocol?
    
    init(router: HistoryRouterProtocol, interactor: HistoryInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension HistoryPresenter: HistoryPresenterProtocol {
    func startDisplayAllAnime() {
        interactor?.loadAnime()
    }
    
    func startDisplayAnime(containing searchString: String) {
        interactor?.loadAnime(containing: searchString)
    }
    
    func didLoadAnime(anime: [HistoryEntity]?) {
        guard let anime = anime else { return }
        view?.showAnime(anime: anime)
    }
    
    func didTapAnimeFactCell(with indexPath: IndexPath) {
        interactor?.loadAnimeFact(with: indexPath)
    }
    
    func didLoadAnimeFact(animeFact: DetailsAnimeFact?) {
        guard let animeFact = animeFact else { return }
        router?.openAnimeFact(for: animeFact)
    }
    
}
