//
//  ViewController.swift
//  Gitty
//
//  Created by DIMa on 17.09.2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        setupSearchBar()
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "accountCell")
    }
    
    func setupSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.textField?.leftView?.tintColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.sizeToFit()
        searchBar.delegate = self
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyWord = searchBar.textField?.text{
            
            viewModel.searchForAccounts(named: keyWord) {
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                    self.searchBar.resignFirstResponder()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect.init(x: 0,y: 0,width: view.frame.width, height: 30))
        if viewModel.items.count != 0 {
            let sortAscButton = UIButton(frame: CGRect(x: 0, y: 0, width: header.frame.width / 2, height: header.frame.height))
            sortAscButton.setTitle("sort ↑", for: .normal)
            if #available(iOS 13.0, *) {
                sortAscButton.backgroundColor = .systemBackground
            } else {
                sortAscButton.backgroundColor = .white
            }
            sortAscButton.setTitleColor(.black, for: .normal)
            //            sortAscButton.titleLabel?.font = UIFont().withSize(30)
            sortAscButton.addTarget(self, action: #selector(self.sortAsc(sender:)), for: .touchUpInside)
            
            let sortDecButton = UIButton(frame: CGRect(x: header.frame.width / 2, y: 0, width: header.frame.width / 2, height: header.frame.height))
            sortDecButton.setTitle("sort ↓", for: .normal)
            if #available(iOS 13.0, *) {
                sortDecButton.backgroundColor = .systemBackground
            } else {
                sortDecButton.backgroundColor = .white
            }
            sortDecButton.setTitleColor(.black, for: .normal)
            sortDecButton.addTarget(self, action: #selector(self.sortDec(sender:)), for: .touchUpInside)
            
            
            header.addSubview(sortAscButton)
            header.addSubview(sortDecButton)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as! AccountTableViewCell
        cell.account = viewModel.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedViewController()
        vc.accountLogin = viewModel.items[indexPath.row].login
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    @objc func sortAsc(sender: UIButton!) {
        viewModel.sortAsc()
        self.tableView.reloadData()
    }
    
    @objc func sortDec(sender: UIButton!) {
        viewModel.sortDec()
        self.tableView.reloadData()
        
    }
    
}
