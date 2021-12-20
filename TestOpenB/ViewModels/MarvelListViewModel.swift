//
//  MarvelListViewModel.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 11/12/21.
//

import Foundation
import UIKit

class MarvelListViewModel: NSObject {
    
    private var service : Service!
    private var offset = 0
    var limit = 30
    
    private(set) var characterListArray : [Results]? {
        didSet {
            self.bindMarvelDetailViewModelToController()
        }
    }
    
    var bindMarvelDetailViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.service = Service()
    }
    
    func getData(dataOffset: Int ) {
        offset += dataOffset
        service.getCharactersList(offsetList: offset, limitList: limit) { (res) in
            switch res {
            case .success(let characters):
                if self.characterListArray != nil {
                    self.characterListArray! += characters
                }else {
                    self.characterListArray = characters
                }
                

            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getArrayCount() -> Int {
        let count = characterListArray?.count ?? 0
        return count
    }
    
    func getHeroId(index: IndexPath) -> Int {
        let id = characterListArray?[index.row].id ?? 0
        return id
    }
    
    func showNextView(navigator: UINavigationController, id: Int) {
        let vc = MarvelDetailController()
        vc.modalPresentationStyle = .fullScreen
        vc.id = id
        navigator.pushViewController(vc, animated: true)
    }
    
    
    
}


