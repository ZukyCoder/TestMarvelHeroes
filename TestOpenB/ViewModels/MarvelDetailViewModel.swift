//
//  MarvelDetailViewModel.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 13/12/21.
//

import Foundation
import UIKit

class MarvelDetailViewModel: NSObject {
    
    private var service : Service!
    
    private(set) var characterArray : [Results]? {
        didSet {
            self.bindMarvelDetailViewModelToController()
        }
    }
    
    var bindMarvelDetailViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        
        self.service = Service()

    }
    
    func showCharacterDetaiil(id:  Int) {
        service.getCharactersDetails(id: id)  { (res) in
            switch res {
            case .success(let characters):
                self.self.characterArray = characters
                print(characters)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    //MARK: -image
    func getImageUrl() -> String {
        let path = characterArray?.first?.thumbnail?.path ?? ""
        let style = ImagesStyles.detail.rawValue
        let ext = ImagesStyles.jpg.rawValue
        let urlString = path+style+ext
        return urlString
    }
    
    
    //MARK: - Titles
    func getName() -> String {
        let stringName = characterArray?.first?.name ?? ""
        
        return stringName
    }
    
    func getComicName() -> String {
        let String = "Comics"
        return String
    }
    
    func getDescriptionTitle() -> String {
        let descriptionTitleString = "Description"
        return descriptionTitleString
    }
    
    func getDescription() -> String {
        let descrptionString = characterArray?.first?.resultDescription ?? ""
        return descrptionString
    }
    
    func getSeriesName() -> String {
        let String = "Series"
        return String
    }
    
    func getStoriesName() -> String {
        let String = "Stories"
        return String
    }
    
    func getEventsName() -> String {
        let String = "Events"
        return String
    }
    
    //MARK: - Items Array
    
    func getComicItems() -> [generalItem] {
        let itemArray = characterArray?.first?.comics?.items ?? []
        return itemArray
    }
    
    func getSeriesItems() -> [generalItem] {
        let itemArray = characterArray?.first?.series?.items ?? []
        return itemArray
    }
    
    func getStoriesItems() -> [generalItem] {
        let itemArray = characterArray?.first?.stories?.items ?? []
        return itemArray
    }
    
    func getEventItems() -> [generalItem] {
        let itemArray = characterArray?.first?.events?.items ?? []
        return itemArray
    }
}
