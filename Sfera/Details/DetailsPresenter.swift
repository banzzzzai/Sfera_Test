//
//  DetailsPresenter.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 22.11.2022.
//

import Foundation

protocol DetailsPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

class DetailsPresenter {
    weak var view: DetailsViewProtocol?
    var router: DetailsRouterProtocol?
    var interactor: DetailsInteractorProtocol?
    
    init(router: DetailsRouterProtocol, interactor: DetailsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension DetailsPresenter: DetailsPresenterProtocol {
    func viewDidLoaded() {
        let animeFact = interactor?.getAnimeFact()
        view?.showAnimeFact(animeFact: animeFact)
    }
    
}
