//
//  TableViewCell.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 20.11.2022.
//

import UIKit
import SnapKit

class SearchFactsTableViewCell: UITableViewCell {

    static let identifier = "TableViewCell"
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fact №1"
        lbl.font = UIFont(name: "Avenir Medium", size: 20)
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
    }
    
}


