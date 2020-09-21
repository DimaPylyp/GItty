//
//  DetailedViewController.swift
//  Gitty
//
//  Created by DIMa on 18.09.2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var accountLogin = String()
    let viewModel = DetailedViewModel()
    
    let tableView = UITableView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        viewModel.searchForAccount(named: accountLogin, completion: {
            
            DispatchQueue.main.async {
                            self.tableView.reloadData()
            }
        })
        
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "repoCell")
    }
    
}


extension DetailedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init(frame: CGRect.init(x: 0,y: 0,width: view.frame.width, height: 200))
        header.backgroundColor = .white
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.downloaded(from: viewModel.item?.avatarUrl ?? "")
        imageView.clipsToBounds = true
        
        let nameLabel = UILabel(frame: CGRect(x: 205, y: 10, width: Int(header.frame.width) - 205, height: 40))
        nameLabel.text = viewModel.item?.name
        
        let loginLabel = UILabel(frame: CGRect(x: 205, y: 50, width: Int(header.frame.width) - 205, height: 40))
        loginLabel.text = viewModel.item?.login
        
        let createdAtLabel = UILabel(frame: CGRect(x: 205, y: 80, width: Int(header.frame.width) - 205, height: 40))
        
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "en_US_POSIX")
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let item = viewModel.item {
            if let date = formater.date(from: item.createdAt) {
                formater.dateStyle = .short
                formater.timeStyle = .none
                createdAtLabel.text = "\(formater.string(from: date))"
            }
        }
        
        let locationLabel = UILabel(frame: CGRect(x: 205, y: 120, width: Int(header.frame.width) - 205, height: 40))
        locationLabel.text = viewModel.item?.location
        
        header.addSubview(imageView)
        header.addSubview(nameLabel)
        header.addSubview(loginLabel)
        header.addSubview(createdAtLabel)
        header.addSubview(locationLabel)
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.item?.repos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoTableViewCell
        cell.repo = viewModel.item?.repos[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? RepoTableViewCell {
//
//                cell.bottomView.isHidden = !cell.bottomView.isHidden
//            tableView.beginUpdates()
//            tableView.setNeedsDisplay()
//            tableView.endUpdates()
////            tableView.deselectRow(at: indexPath, animated: true)
//        }
//    }
    
}

