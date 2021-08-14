//
//  SearchViewController.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/28/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        return searchBar
    }()
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(NewConversationCellTableViewCell.self , forCellReuseIdentifier: NewConversationCellTableViewCell.identifier)
        return table
    }()
    private let NoResultLabel : UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results"
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 21, weight : .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel", style: .done, target: self, action: #selector(dismissself))
        view.addSubview(NoResultLabel)
        view.addSubview(tableView)
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .secondarySystemBackground
        searchBar.becomeFirstResponder()
    }
    
    @objc private func dismissself(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        NoResultLabel.frame = CGRect(x: view.width/4, y: (view.height-200)/2, width: view.width/2, height: 200)
    }

}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
        return cell!
    }
    
    
}

extension SearchViewController: UISearchBarDelegate{
    
}
