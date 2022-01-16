//
//  Extension+ViewController.swift
//  Match Info
//
//  Created by Harshal Pathak on 16/01/22.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {

    func showHUD(progressLabel:String){
        DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
        }
    }

    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}
