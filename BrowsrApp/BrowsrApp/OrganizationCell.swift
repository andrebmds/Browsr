//
//  OrganizationTableViewCell.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/18/23.
//

import UIKit

class OrganizationCell: UITableViewCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Gione"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .natural
        return label
    }()
    
    let avatarImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "placeHolder"))
        view.contentMode = .scaleAspectFit
        view.frame.size = CGSize(width: 50, height: 50)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(avatarImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConstraints() {
        // Set up constraints for the name label and avatar image view.
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}