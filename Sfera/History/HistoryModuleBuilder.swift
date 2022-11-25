//
//  HistoryModuleBuilder.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 21.11.2022.
//

import Foundation

class HistoryModuleBuilder {
    static func build() -> HistoryViewController {
        let animeFetchService = CoreDataManager()
        let interactor = HistoryInteractor(animeFetchService: animeFetchService)
        let router = HistoryRouter()
        let presenter = HistoryPresenter(router: router, interactor: interactor)
        let viewController = HistoryViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
