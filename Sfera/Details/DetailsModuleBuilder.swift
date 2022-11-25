//
//  DetailsModuleBuilder.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 22.11.2022.
//

import Foundation

class DetailsModuleBuilder {
    static func build(animeFact: DetailsAnimeFact) -> DetailsViewController {
        let interactor = DetailsInteractor(animeFact: animeFact)
        let router = DetailsRouter()
        let presenter = DetailsPresenter(router: router, interactor: interactor)
        let viewController = DetailsViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
