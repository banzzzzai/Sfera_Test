//
//  DetailsViewController.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 22.11.2022.
//

import Foundation
import SnapKit
import UIKit

protocol DetailsViewProtocol: AnyObject {
    func showAnimeFact(animeFact: DetailsAnimeFact?)
}

class DetailsViewController: UIViewController {
    
    let factLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fact"
        lbl.font = UIFont(name: "Avenir", size: 30)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()

    var presenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUp()
    }
    
    private func setUp() {
        
        view.backgroundColor = .secondarySystemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(factLabel)
        
        factLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        presenter?.viewDidLoaded()
    }
}

extension DetailsViewController: DetailsViewProtocol {
    
    func showAnimeFact(animeFact: DetailsAnimeFact?) {
        guard let animeFact = animeFact else { return }

        DispatchQueue.main.async {
            self.title = "Fact №\(animeFact.factId)"
            self.factLabel.text = animeFact.fact
        }
    }
    
    
}
