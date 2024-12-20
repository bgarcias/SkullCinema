//
//  ExtensionUIViewController.swift
//  SkullCinema
//
//  Created by Brandon Garcia Sanchez on 04/12/2024.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(_ message : String) {
        let toastLabel = UILabel(
            frame: CGRect(x: 20, y: self.view.frame.size.height * 0.8,
                          width: self.view.frame.size.width - 40, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: CGFloat(15))
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(
            withDuration: 4.0,
            delay: 0.1,
            options: .curveEaseOut,
            animations: { toastLabel.alpha = 0.0 },
            completion: {(isCompleted) in toastLabel.removeFromSuperview()}
        )
    }
}
