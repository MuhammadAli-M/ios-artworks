//
//  AlertAction.swift
//  Artworks
//
//  Created by Muhammad Adam on 27/12/2021.
//

import UIKit

struct AlertAction{
    enum AlertActionType{
        case destructive
        case normal
        case cancel
    }
    let title: String
    let block: (() -> Void)?
    let type: AlertActionType
}

extension AlertAction{
    func toUIAlertAction() -> UIAlertAction{
        let styles:[AlertActionType:UIAlertAction.Style] = [
            .destructive: .destructive,
            .normal: .default,
            .cancel: .cancel
        ]
        return UIAlertAction(title: self.title, style: styles[self.type] ?? .default) { uiAlertAction in
            block?()
        }
    }
}
