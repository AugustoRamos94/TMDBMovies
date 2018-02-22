//
//  UIViewController+Extension.swift
//  TMDB Movies
//
//  Created by Augusto Ramalho Ramos on 20/02/18.
//  Copyright © 2018 AugustoRamalhoRamos. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
    
    func showAlert(title: String,
                   message: String,
                   actions: [UIAlertAction] = [],
                   defaultCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        if actions.isEmpty {
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                defaultCompletion?()
            }))
        } else {
            actions.forEach({ alertController.addAction($0) })
        }
        
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    func showAlertError(completion: (() -> Void)? = nil,
                        tryAgainCompletion: (() -> Void)? = nil) {
        var actions:[UIAlertAction] = [UIAlertAction(title: "OK",
                                                     style: .default,
                                                     handler: { _ in
                                                        completion?()
        })]
        
        if tryAgainCompletion != nil {
            actions.append(UIAlertAction(title: "Try again",
                                         style: .default,
                                         handler: { _ in
                                            tryAgainCompletion?()
            }))
        }
        
        showAlert(title: "Ops",
                  message: "There was a problem",
                  actions: actions)
    }
}

