//
//  ImageExtension.swift
//  TestOpenB
//
//  Created by Mario Andres Heberthardt Marchant on 16/12/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageUsingUrlString(urlString: String) {
        let url = URL(string: urlString)!
        image = nil
        URLSession.shared.dataTask(with: url, completionHandler: { (data, res, err) in
            if err != nil {
                print(err as Any)
                return
            }
            
            DispatchQueue.main.async {
                if let urlData = data {
                    self.image = UIImage(data: urlData)
                }
            }
        }).resume()
    }
}
