//
//  HomeTableViewCell.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 8/12/21.
//

import UIKit

struct CellModel {
    
    let id: Int
    let name: String
    let description: String
    let detailLink: String
    let wikiLink: String
    let comicLink: String
    let thumbnailPath: String
    
    init(details: Results) {
        self.id = details.id ?? 0
        self.name = details.name ?? ""
        self.description = details.resultDescription ?? ""
        self.detailLink = "Detail"
        self.wikiLink = "Wiki"
        self.comicLink = "Comic Link"
        self.thumbnailPath = details.thumbnail?.path ?? ""
        
    }
    
}

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    private lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleName: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.font = UIFont.boldSystemFont(ofSize: 22)
        return title
    }()
    
    private lazy var characterDescription: UILabel = {
        let descriptionString = UILabel()
        descriptionString.numberOfLines = 3
        descriptionString.font = UIFont.systemFont(ofSize: 16)
        return descriptionString
    }()
    
    private lazy var stackLink: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [datailLink, wikiLink, comicLink])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    private lazy var datailLink: UILabel = {
        let detailString = UILabel()
        
        detailString.font = UIFont.systemFont(ofSize: 14)
        detailString.textColor = UIColor.blue
        detailString.isUserInteractionEnabled = true
        let tap = UIGestureRecognizer(target: self, action: #selector(callWebLink))
        detailString.addGestureRecognizer(tap)
        return detailString
    }()
    
    private lazy var wikiLink: UILabel = {
        let wikiString = UILabel()
        wikiString.font = UIFont.systemFont(ofSize: 14)
        wikiString.textColor = UIColor.blue
        wikiString.isUserInteractionEnabled = true
        return wikiString
    }()
    
    private lazy var comicLink: UILabel = {
        let comicString = UILabel()
        comicString.font = UIFont.systemFont(ofSize: 14)
        comicString.textColor = UIColor.blue
        comicString.isUserInteractionEnabled = true
        return comicString
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func commonInit() {
        
        setupImageLayout()
        setupTitlenameLayout()
        setupDescriptionLayout()
        setupStackLayout()
    }
    
    private func setupCellLayout(){
        //to call external link
    }
    
    private func setupImageLayout() {
        self.addSubview(cellImage)
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant: 180).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        cellImage.layer.masksToBounds = false
        cellImage.layer.cornerRadius = 12
        cellImage.clipsToBounds = true
    }
    
    private func setupTitlenameLayout() {
        self.addSubview(titleName)
        titleName.translatesAutoresizingMaskIntoConstraints = false
        titleName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleName.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        titleName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        titleName.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
    }
    
    private func setupDescriptionLayout() {
        self.addSubview(characterDescription)
        characterDescription.translatesAutoresizingMaskIntoConstraints = false
        characterDescription.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 10).isActive = true
        characterDescription.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        characterDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupStackLayout() {
        self.addSubview(stackLink)
        stackLink.translatesAutoresizingMaskIntoConstraints = false
        stackLink.topAnchor.constraint(equalTo: characterDescription.bottomAnchor, constant: 10).isActive = true
        stackLink.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 10).isActive = true
        stackLink.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        stackLink.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
    
    
    @objc private func callWebLink() {
        print("WEB LINK")
    }
    
    func configure(data: CellModel) {
    
        let cellData = data
        self.cellImage.image =  UIImage(systemName: "person.badge.clock")
        self.titleName.text = cellData.name
        self.characterDescription.text = cellData.description
        self.datailLink.text = data.detailLink
        self.wikiLink.text = data.wikiLink
        self.comicLink.text = data.comicLink
        let path = cellData.thumbnailPath
        let thumUrl = path+ImagesStyles.standard_amazing.rawValue+ImagesStyles.jpg.rawValue
        cellImage.loadImageUsingUrlString(urlString: thumUrl)
        
        self.layoutIfNeeded()
    }
}
