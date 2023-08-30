//
//  File.swift
//  
//
//  Created by Thiago dos Santos Martins on 30/08/23.
//

import UIKit.UITableViewCell

final class PGListTableViewCell: UITableViewCell {
    static let identifier = String(describing: PGListTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


