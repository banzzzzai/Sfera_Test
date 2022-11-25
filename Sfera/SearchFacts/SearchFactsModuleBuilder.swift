//
//  SearchFactsModuleBuilder.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 20.11.2022.
//

import UIKit

class SearchFactsModuleBuilder {
    static func build() -> SearchFactsViewController {
        let networkService = AnimeFactsService()
        let interactor = SearchFactsInteractor(animeFactsService: networkService)
        let router = SearchFactsRouter()
        let presenter = SearchFactsPresenter(router: router, interactor: interactor)
        let viewController = SearchFactsViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
