//
//  SearchFactsRouter.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 20.11.2022.
//

import Foundation

protocol SearchFactsRouterProtocol {
    func openAnimeFact(for animeFact: DetailsAnimeFact)
}

class SearchFactsRouter: SearchFactsRouterProtocol {
    weak var viewController: SearchFactsViewController?
    
    func openAnimeFact(for animeFact: DetailsAnimeFact) {
        let vc = DetailsModuleBuilder.build(animeFact: animeFact)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
