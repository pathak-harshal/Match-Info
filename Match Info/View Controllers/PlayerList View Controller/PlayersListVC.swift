//
//  PlayersListVC.swift
//  Match Info
//
//  Created by Harshal Pathak on 16/01/22.
//

import UIKit
import XLPagerTabStrip

class PlayersListVC: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var tblPlayerList: UITableView!
    
    var itemInfo: IndicatorInfo = "View"
    var teamId: Int64 = 0
    var players = [Player]()
    
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblPlayerList.delegate = self
        tblPlayerList.dataSource = self
        tblPlayerList.register(UITableViewCell.self, forCellReuseIdentifier: K.CellIndetifier.playerCell)
        players = DataBaseManger.fetchPlayers(teamId: teamId)
        print("Count \(players.count)")
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

extension PlayersListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: K.CellIndetifier.playerCell, for: indexPath)
        let player = players[indexPath.row]
        var playerName = player.player_name!
        if player.player_is_captain {
            playerName = "\(playerName) (c)"
        }
        if player.player_is_wicket_keeper {
            playerName = "\(playerName) (wk)"
        }
        cell.textLabel?.text = playerName
        
        return cell
    }
    
    
}
