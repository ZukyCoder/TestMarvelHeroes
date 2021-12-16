//
//  MarvelListController.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 4/12/21.
//

import UIKit

class MarvelListController: UITableViewController {
    
    private var marvelListViewModel : MarvelListViewModel!
    
    private let distanceFromBottom = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callViewModelUpdate()
        
        setupNavBar()
        setupTableView()
        
    }
    
    func callViewModelUpdate() {
        self.marvelListViewModel = MarvelListViewModel()
        self.marvelListViewModel.getData(dataOffset: 0)
        self.marvelListViewModel.bindMarvelDetailViewModelToController = {
            self.callUpdateData()
        }
    }
    
    func callUpdateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("DATA LOADED")
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = marvelListViewModel.getArrayCount()
        print(count)
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier ) as? HomeTableViewCell else { return UITableViewCell() }
        if let cellData = marvelListViewModel.characterListArray?[indexPath.row] {
            cell.configure(data: CellModel(details: cellData ))}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroId = marvelListViewModel.getHeroId(index: indexPath)
        goNextView(id: heroId)
        
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      
      let currentOffset = scrollView.contentOffset.y
      let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

      if maximumOffset - currentOffset <= distanceFromBottom {
          let offset = marvelListViewModel.limit
          self.marvelListViewModel.getData(dataOffset: offset)
      }
    }
    
     
    func goNextView(id: Int) {
        let vc = MarvelDetailController()
        vc.modalPresentationStyle = .fullScreen
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupTableView(){
        tableView.register(HomeTableViewCell.self , forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    func setupNavBar() {
        navigationItem.title = "Marvel Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemPurple
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 50, g: 199, b: 242)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
    }

}

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
