//
//  MatchInfoViewVC.swift
//  Match Info
//
//  Created by Harshal Pathak on 15/01/22.
//

import UIKit
import Material

class MatchInfoViewVC: BottomNavigationController {
    
    static func instantiate() -> MatchInfoViewVC? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(MatchInfoViewVC.self)") as? MatchInfoViewVC
    }
    
    open override func prepare() {
        super.prepare()
        isMotionEnabled = true
        motionTabBarTransitionType = .autoReverse(presenting: .pull(direction: .left))
        
        prepareTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = DataBaseManger.getTitle()
    }
        
    fileprivate func prepareTabBar() {
        tabBar.depthPreset = .none
        tabBar.dividerColor = Color.grey.lighten2
    }
    
}
