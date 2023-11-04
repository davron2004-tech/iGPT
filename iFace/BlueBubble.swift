//
//  Bubble.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 02/11/23.
//

import UIKit

class BlueBubble: UITableViewCell {
    
    let cellText = UILabel()
    let cellBackground = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellBackground()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(){
        cellBackground.addSubview(cellText)
        cellText.numberOfLines = 0
        cellText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellText.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 10),
            cellText.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -10),
            cellText.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 5),
            cellText.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -5)
        ])
    }
    func configureCellBackground(){
        contentView.addSubview(cellBackground)
        cellBackground.backgroundColor = UIColor(named: "BlueBubble")
        cellBackground.layer.cornerRadius = 8
        cellBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            cellBackground.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10)
            
        ])
    }
    
}
