//
//  MarvelListController.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 4/12/21.
//

import UIKit

class MarvelListController: UITableViewController {
    
    
    var cellID = "HomeTableViewCell"
    
    let serviceProxy = Service.share
    
    var offset = 0
    var limit = 30
    
    private let distanceFromBottom = 10.0
    
    var listArr:[MarvelListViewModel]? = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        getData(dataOffset: offset )
        
    }
    
    func getData(dataOffset: Int ) {
        serviceProxy.getCharactersList(offsetList: dataOffset, limitList: limit) { (res) in
            switch res {
            case .success(let characters):
                self.setDataList(details: characters)

            case .failure(let err):
                print(err)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? HomeTableViewCell else { return UITableViewCell() }
       
        if let hero = listArr?[indexPath.row] {
            cell.configure(data: hero)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let heroId = listArr?[indexPath.row].id  {
        goNextView(id: heroId)
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      
      let currentOffset = scrollView.contentOffset.y
      let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

      if maximumOffset - currentOffset <= distanceFromBottom {
        offset += limit
          getData(dataOffset: offset)
      }
    }
    
     
    func goNextView(id: Int) {
        let vc = MarvelDetailController()
        vc.modalPresentationStyle = .fullScreen
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setDataList(details: [Results]) {
        let infoDetails = details.map({return MarvelListViewModel(details: $0)})
        if self.listArr == nil {
            listArr = infoDetails
        } else {
            listArr!  += infoDetails
        }
    }
    
    func setupTableView(){
        tableView.register(HomeTableViewCell.self , forCellReuseIdentifier: cellID)
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
