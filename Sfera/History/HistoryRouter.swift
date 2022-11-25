//
//  HistoryRouter.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 21.11.2022.
//

import Foundation

protocol HistoryRouterProtocol {
    func openAnimeFact(for animeFact: DetailsAnimeFact)
}

class HistoryRouter: HistoryRouterProtocol {
    weak var viewController: HistoryViewController?
    
    func openAnimeFact(for animeFact: DetailsAnimeFact) {
        let vc = DetailsModuleBuilder.build(animeFact: animeFact)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

