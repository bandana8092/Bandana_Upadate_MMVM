//
//  Extensions.swift
//  Bandana_Eng_AI
//
//  Created by satish pullagura on 02/02/20.
//  Copyright © 2020 Bandana. All rights reserved.
//

import Foundation
import UIKit
extension String {
    func convertdateToFormate(formate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"//2020-02-02T15:48:21.000Z"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = self
        return  dateFormatter.string(from: date!)
    }
}
@available(iOS 13.0, *)

extension UIViewController {
    var appDelegate: AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    func showAlertWith(message: String) {
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func setupSpinnerWith(style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
         let activitySpinner = UIActivityIndicatorView()
         activitySpinner.style = style
         activitySpinner.color = UIColor.darkGray
         return activitySpinner
    }
    func showSpinnerAt(destination: Destination, spinner: UIActivityIndicatorView) {
        let frameCenter = CGRect.init(x: self.view.center.x - 25, y: self.view.center.y, width: 50, height: 50)
         let frameBottom = CGRect.init(x: self.view.center.x - 25, y: screenHeight - 64, width: 50, height: 50)
         switch destination {
         case .bottom:
            spinner.frame = frameBottom
         case .center:
             spinner.frame = frameCenter
         }
        spinner.startAnimating()
        spinner.isHidden = false
        self.view.addSubview(spinner)
    }
    func hideSpinner(spinner: UIActivityIndicatorView) {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
}
