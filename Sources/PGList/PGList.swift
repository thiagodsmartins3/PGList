//
//  File.swift
//
//
//  Created by Thiago dos Santos Martins on 30/08/23.
//

#if canImport(UIKit)

import UIKit.UIView
import Alamofire

// MARK: DELEGATE PROTOCOL
@objc public protocol PGListDelegate: AnyObject {
    @objc optional func pgListTableView(_ tableView: UITableView,
                                        cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

public class PGList<T, U: PGListDelegate>: UIView,
                                           UITableViewDelegate,
                                           UITableViewDataSource {

    // MARK: VARIABLES
    private lazy var pgListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PGListTableViewCell.self,
                           forCellReuseIdentifier: PGListTableViewCell.identifier)
        tableView.delegate =  self as any UITableViewDelegate
        tableView.dataSource = self as any UITableViewDataSource
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var pgListData: [T] = [] {
        didSet {
            pgListTableView.reloadData()
        }
    }
    
    private var customCellIdentifier = ""
    public weak var delegate: U?
    
    // MARK: FUNCTIONS
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(_ url: String) {
        self.init(frame: CGRect.zero)
        
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupViews() {
        addSubview(pgListTableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pgListTableView.topAnchor.constraint(equalTo: topAnchor),
            pgListTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pgListTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pgListTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func customCell(_ cell: AnyClass?, identifier: String) {
        guard let customCell = cell else {
            return
        }
        
        pgListTableView.register(customCell, forCellReuseIdentifier: identifier)
        customCellIdentifier = identifier
    }
    
    // MARK: TABLE VIEW DELEGATE FUNCTIONS
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return pgListData.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if !customCellIdentifier.isEmpty {
            guard let delegate = delegate else {
                return UITableViewCell()
            }
            
            return delegate.pgListTableView!(tableView, cellForRowAt: indexPath)
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PGListTableViewCell.identifier, for: indexPath) as? PGListTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        }
    }
}

#endif
