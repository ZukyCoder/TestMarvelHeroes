//
//  CustomNavBarViewController.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 11/12/21.
//

import UIKit

class CustomNavBarViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        
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
