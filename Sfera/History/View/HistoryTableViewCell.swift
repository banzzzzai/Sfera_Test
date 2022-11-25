//
//  HistoryTableViewCell.swift
//  Sfera
//
//  Created by Афанасьев Александр Иванович on 21.11.2022.
//

import UIKit
import SnapKit

class HistoryTableViewCell: UITableViewCell {

    static let identifier = "HistoryTableViewCell"
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fact №1"
        lbl.font = UIFont(name: "Avenir Medium", size: 15)
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
