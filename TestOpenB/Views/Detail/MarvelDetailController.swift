//
//  MarvelDetailController.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 10/12/21.
//

import UIKit

class MarvelDetailController: UIViewController, UIScrollViewDelegate {
    
    
    var id:Int?
    private var marvelDetailViewModel: MarvelDetailViewModel?
    
    private lazy var mainScrollView : UIScrollView = {
        let mScroll = UIScrollView()
        mScroll.delegate = self
        mScroll.contentInsetAdjustmentBehavior = .never
        mScroll.translatesAutoresizingMaskIntoConstraints = false
        mScroll.showsVerticalScrollIndicator = false
        return mScroll
    }()
    
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        return imageView
    }()
    
    private lazy var mainStack: UIStackView = {
       let mStack = UIStackView(arrangedSubviews: [descriptionStack, comicStack, seriesStack, storiesStack, eventsStack])
        mStack.axis = .vertical
        mStack.distribution = .fillProportionally
        mStack.alignment = .fill
        mStack.spacing = 10
        mStack.layoutIfNeeded()
        return mStack
    }()
    
    // description
    private lazy var descriptionStack: UIStackView = {
        let dStack = UIStackView(arrangedSubviews: [descriptionTitle, descriptionLabel])
        dStack.translatesAutoresizingMaskIntoConstraints = false
        dStack.axis = .vertical
        dStack.spacing = 5
        return dStack
    }()
    
    private lazy var descriptionTitle : UILabel = {
        let dTitle = UILabel()
        dTitle.translatesAutoresizingMaskIntoConstraints = false
        dTitle.font = UIFont.boldSystemFont(ofSize: 20)
        return dTitle
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let dLabel = UILabel()
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.numberOfLines = 0
        dLabel.font = UIFont.systemFont(ofSize: 15)
        dLabel.textAlignment = .justified
        return dLabel
    }()
    
    // comics
    
    private lazy var comicStack: UIStackView = {
        let cStack = UIStackView(arrangedSubviews: [comicTitle])
        cStack.translatesAutoresizingMaskIntoConstraints = false
        cStack.axis = .vertical
        cStack.spacing = 5
        return cStack
    }()
    
    private lazy var comicTitle : UILabel = {
        let cTitle = UILabel()
        cTitle.translatesAutoresizingMaskIntoConstraints = false
        cTitle.text = marvelDetailViewModel?.getComicName()
        cTitle.font = UIFont.boldSystemFont(ofSize: 20)
        return cTitle
    }()
    
    
    // series
    private lazy var seriesStack: UIStackView = {
        let sStack = UIStackView(arrangedSubviews: [seriesTitle])
        sStack.translatesAutoresizingMaskIntoConstraints = false
        sStack.axis = .vertical
        sStack.spacing = 5
        return sStack
    }()
    
    private lazy var seriesTitle : UILabel = {
        let sTitle = UILabel()
        sTitle.translatesAutoresizingMaskIntoConstraints = false
        sTitle.text = marvelDetailViewModel?.getSeriesName()
        sTitle.font = UIFont.boldSystemFont(ofSize: 20)
        return sTitle
    }()
    
    //stories
    private lazy var storiesStack: UIStackView = {
        let stStack = UIStackView(arrangedSubviews: [storiesTitle])
        stStack.translatesAutoresizingMaskIntoConstraints = false
        stStack.axis = .vertical
        stStack.spacing = 5
        return stStack
    }()
    
    private lazy var storiesTitle : UILabel = {
        let stTitle = UILabel()
        stTitle.translatesAutoresizingMaskIntoConstraints = false
        stTitle.text = marvelDetailViewModel?.getStoriesName()
        stTitle.font = UIFont.boldSystemFont(ofSize: 20)
        return stTitle
    }()
    
    // events
    private lazy var eventsStack: UIStackView = {
        let eStack = UIStackView(arrangedSubviews: [eventsTitle])
        eStack.translatesAutoresizingMaskIntoConstraints = false
        eStack.axis = .vertical
        eStack.spacing = 5
        return eStack
    }()
    
    private lazy var eventsTitle : UILabel = {
        let eTitle = UILabel()
        eTitle.translatesAutoresizingMaskIntoConstraints = false
        eTitle.text = marvelDetailViewModel?.getEventsName()
        eTitle.font = UIFont.boldSystemFont(ofSize: 20)
        return eTitle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callViewModelUpdate()
        
        setView()
        setupNavBar()
        self.view.layoutIfNeeded()
    }
    
    func callViewModelUpdate() {
        self.marvelDetailViewModel = MarvelDetailViewModel()
        marvelDetailViewModel?.showCharacterDetaiil(id: id ?? 0)
        marvelDetailViewModel?.bindMarvelDetailViewModelToController = {
            self.callUpdateViewController()
        }
    }
    
    func callUpdateViewController() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.marvelDetailViewModel?.getName()
            //image
            let stringImage = self.marvelDetailViewModel?.getImageUrl()
            self.characterImage.loadImageUsingUrlString(urlString: stringImage!)
            //description
            self.descriptionTitle.text = self.marvelDetailViewModel?.getDescriptionTitle()
            self.descriptionLabel.text = self.marvelDetailViewModel?.getDescription()
            //comics
            let comicItemsStack = UIStackView(arrangedSubviews: self.createViews(items: self.marvelDetailViewModel?.getComicItems() ?? []))
            comicItemsStack.axis = .vertical
            comicItemsStack.spacing = 5
            comicItemsStack.alignment = .fill
            self.comicStack.addArrangedSubview(comicItemsStack)
            //series
            let seriesItemsStack = UIStackView(arrangedSubviews: self.createViews(items: self.marvelDetailViewModel?.getSeriesItems() ?? []))
            seriesItemsStack.axis = .vertical
            seriesItemsStack.spacing = 5
            seriesItemsStack.alignment = .fill
            self.seriesStack.addArrangedSubview(seriesItemsStack)
            //stories
            let storiesItemsStack = UIStackView(arrangedSubviews: self.createViews(items: self.marvelDetailViewModel?.getStoriesItems() ?? []))
            storiesItemsStack.axis = .vertical
            storiesItemsStack.spacing = 5
            storiesItemsStack.alignment = .fill
            self.storiesStack.addArrangedSubview(storiesItemsStack)
            //events
            let eventsItemsStack = UIStackView(arrangedSubviews: self.createViews(items: self.marvelDetailViewModel?.getEventItems() ?? []))
            eventsItemsStack.axis = .vertical
            eventsItemsStack.spacing = 5
            eventsItemsStack.alignment = .fill
            self.eventsStack.addArrangedSubview(eventsItemsStack)
            self.view.layoutIfNeeded()
        }
    }
    
    func setView() {
        self.view.backgroundColor = UIColor.white
        setupMainScrollLayout()
        self.view.layoutIfNeeded()
    }
    
    func setupNavBar() {
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func createViews(items:[generalItem]) -> [UIView] {
        var stackViewArray = [UILabel]()
        for item in items {
            let lable = UILabel()
            lable.text = item.name
            lable.numberOfLines = 0
            stackViewArray.append(lable)
        }
        return stackViewArray
    }
    
    
    func setupMainScrollLayout() {
        self.view.addSubview(mainScrollView)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mainScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
        setImageLayout()
        setupMainStackLayout()
    }

    // setupLayout
    func setImageLayout() {
        mainScrollView.addSubview(characterImage)
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        characterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        characterImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    }

    func setupMainStackLayout() {
        mainScrollView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 10).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -20).isActive = true
        
    }
}

