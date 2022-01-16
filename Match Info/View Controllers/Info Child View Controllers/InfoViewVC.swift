//
//  InfoViewVC.swift
//  Match Info
//
//  Created by Harshal Pathak on 15/01/22.
//

import UIKit
import XLPagerTabStrip


class InfoViewVC: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = UIColor.clear
        settings.style.buttonBarItemBackgroundColor = UIColor.clear
        settings.style.selectedBarBackgroundColor = UIColor(red: 231/255.0, green: 120/255.0, blue: 23/255.0, alpha: 1.0)
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarItemTitleColor = .white
        
        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black.withAlphaComponent(0.39)
            newCell?.label.textColor = .black
            
        }
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        containerView.isScrollEnabled = false
        var viewControllers = [UIViewController]()
        
        let teams = DataBaseManger.fetchAllTeamswithPlayers()
        
        for team in teams {
//            let teamId = Int(team.team_id)
            let viewController = PlayersListVC(itemInfo: IndicatorInfo(title: team.team_name!))
            viewController.teamId = team.team_id
            viewControllers.append(viewController)
        }
        
        return viewControllers
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
