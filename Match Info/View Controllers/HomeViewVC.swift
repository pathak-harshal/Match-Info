//
//  HomeViewVC.swift
//  Match Info
//
//  Created by Harshal Pathak on 15/01/22.
//

import UIKit
import Material
import CoreData

class HomeViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionOpenInfo(_ sender: UIButton) {
        let tag = sender.tag
        self.showHUD(progressLabel: "Loading")
        DataBaseManger.saveTeamsPlayersToDB(fromUrl: tag) { isSuccess in
            self.dismissHUD(isAnimated: true)
            if isSuccess {
                guard let matchInfoVC = MatchInfoViewVC.instantiate() else { return }
                self.navigationController?.pushViewController(matchInfoVC, animated: true)
            }
        }
    }
    
}

