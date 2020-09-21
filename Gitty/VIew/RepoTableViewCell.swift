//
//  RepoTableViewCell.swift
//  Gitty
//
//  Created by DIMa on 20.09.2020.
//  Copyright © 2020 DIMa. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
        
    var repo: Repo? {
        didSet{
            guard let repoItem = repo else { return }
            nameLabel.text = repoItem.name
            langugeLabel.text = repoItem.language
            
            let formater = DateFormatter()
            formater.locale = Locale(identifier: "en_US_POSIX")
            formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            guard let date = formater.date(from: repoItem.updated_at) else {return}
            formater.dateStyle = .short
            formater.timeStyle = .none
            updatedAtLabel.text = "\(formater.string(from: date))"
            starsLabel.text = String(repoItem.stargazers_count)
        }
    }
    
//    var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.distribution = .fill
//        stackView.alignment = .fill
//        stackView.spacing = 50
//        return stackView
//    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var langugeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.isHidden = true
        return view
    }()
    
    var updatedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var starsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
//        contentView.addSubview(stackView)
//        stackView.addSubview(nameLabel)
//        stackView.addSubview(langugeLabel)
//        stackView.addSubview(bottomView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(langugeLabel)
        contentView.addSubview(bottomView)
        
        bottomView.addSubview(updatedAtLabel)
        bottomView.addSubview(starsLabel)
        
//        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        langugeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: langugeLabel.leadingAnchor, constant: 0).isActive = true

        langugeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        langugeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true

        updatedAtLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 2).isActive = true
        updatedAtLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 2).isActive = true

        starsLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 2).isActive = true
        starsLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -2).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
