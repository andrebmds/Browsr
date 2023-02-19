//
//  OrganizationTableViewCell.swift
//  BrowsrApp
//
//  Created by Andre Bortoli on 2/18/23.
//

import UIKit

class OrganizationCell: UITableViewCell {
    private var viewModel: OrganizationCellViewModel?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textAlignment = .natural
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.frame.size = CGSize(width: 50, height: 50)
        return view
    }()
    
    private var avatarImageCache = NSCache<NSString, UIImage>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(avatarImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        nameLabel.text = nil
        avatarImageView.image = nil
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
    
    func configure(with viewModel: OrganizationCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        viewModel.loadImage { [weak self] image in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            }
        }
    }
}
//}
