//
//  MarvelListViewModel.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 11/12/21.
//

import Foundation

struct MarvelListViewModel {
    
    let id: Int
    let name: String
    let description: String
    let detailLink: String
    let wikiLink: String
    let comicLink: String
    let thumbnailPath: String
    let thumbnailExt: String
    
    
    init(details: Results) {
        
        self.id = details.id ?? 0
        self.name = details.name ?? ""
        self.description = details.resultDescription ?? ""
        self.detailLink = "Detail"
        self.wikiLink = "Wiki"
        self.comicLink = "Comic Link"
        self.thumbnailPath = details.thumbnail?.path ?? ""
        self.thumbnailExt = ".\(details.thumbnail?.thumbnailExtension ?? "jpg")"
    }
    
}


