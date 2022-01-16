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
        DataBaseManger.saveTeamsPlayersToDB(fromUrl: 1) { isSuccess in
            print("Came back to viewcontroller")
            if isSuccess {
                
                guard let matchInfoVC = MatchInfoViewVC.instantiate() else { return }
                self.navigationController?.pushViewController(matchInfoVC, animated: true)
            }
        }
    }
    
}

