//
//  ServiceManager.swift
//  Match Info
//
//  Created by Harshal Pathak on 15/01/22.
//

import Foundation
import SwiftyJSON

/* Class dedicated to the service layer */
class ServiceManager: NSObject {
    class func loadTeams (fromUrl: Int, _ completionBlock : @escaping (_ responseArray: Data?, _ errorObj : NSError?)->()) {
        NetworkManger.requestForType(serviceType: fromUrl == 1 ? ServiceType.forFirstURL : ServiceType.forSecondURL, params: nil) { (response, error) in
            if let error = error {
                completionBlock(nil, error)
            }else if let response = response {
                completionBlock(response, nil)
            }
        }
    }
}
