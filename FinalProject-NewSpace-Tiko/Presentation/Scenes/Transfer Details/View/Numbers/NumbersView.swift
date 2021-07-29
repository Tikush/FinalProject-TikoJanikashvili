//
//  Numbers.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

protocol NumberDelegate: AnyObject {
    func selectedNumber(number: String, name: String, symbol: String)
}

class NumbersView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private weak var lineView: UIView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private Properties
    private var numbers: [String] = []
    private var image: UIImage?
    private var symbol = ""
    weak var delegate: NumberDelegate?
    
    // MARK: - Life Cyrcle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        lineView.cornerView(cornerRadius: 2.5, borderWidth: 0.3, borderColor: .lightGray)
    }
    
    func dataset(with item: Contact) {
        fullNameLabel.text = "\(item.name) \(item.lastName)"
        if item.picture != nil {
            image = UIImage(data: item.picture!)
        }
        numbers = item.numbers
        symbol = item.symbol
    }
    
    func setupLayout() {
        tableView.registerNib(class: NumberCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension NumbersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(NumberCell.self, for: indexPath)
        cell.configureCell(with: numbers[indexPath.row])
        return cell
    }
}

extension NumbersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedNumber(number: numbers[indexPath.row], name: fullNameLabel.text ?? "", symbol: fullNameLabel.text ?? "")
    }
}
