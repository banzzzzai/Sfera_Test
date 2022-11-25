//
//  DetailsInteractor.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 22.11.2022.
//

import Foundation

protocol DetailsInteractorProtocol: AnyObject {
    func getAnimeFact() -> DetailsAnimeFact?
}

class DetailsInteractor: DetailsInteractorProtocol {
    weak var presenter: DetailsPresenterProtocol?
    let animeFact: DetailsAnimeFact
    
    init(animeFact: DetailsAnimeFact) {
        self.animeFact = animeFact
    }
    
    func getAnimeFact() -> DetailsAnimeFact? {
        return animeFact
    }
}
