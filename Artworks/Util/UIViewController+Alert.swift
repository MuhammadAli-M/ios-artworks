//
//  UIViewController+Alert.swift
//  Artworks
//
//  Created by Muhammad Adam on 27/12/2021.
//

import UIKit

extension UIViewController{
    func showAlert(title: String, message: String, actions: [AlertAction]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions
            .map { $0.toUIAlertAction() }
            .forEach{ alert.addAction($0) }
        present(alert, animated: true)
    }
}
