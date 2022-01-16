//
//  NetworkManger.swift
//  Match Info
//
//  Created by Harshal Pathak on 15/01/22.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON


/* Class dedicated to the Network layer */

enum ServiceType: URLConvertible{
    
    case forFirstURL
    case forSecondURL
    
    func asURL() throws -> URL {
        return URL.init(string: self.URLString)!
    }
    //TODO : ADD UR LCONSTANTS FILE
    var URLString : String{
        switch self{
        case .forFirstURL:
            return "https://www.sportsadda.com/cricket/live/json/sapk01222019186652.json"
            //Add more when required
        default:
            return "https://www.sportsadda.com/cricket/live/json/nzin01312019187360.json"
        }
    }
    var requestMethod : Alamofire.HTTPMethod{
        switch self{
        case .forFirstURL, .forSecondURL:
            return .get
        }
    }
}

class NetworkManger: NSObject {
    
    class func requestForType(serviceType : ServiceType, params:[String: Any]?, completionBlock :@escaping (_ response: Data?,_ error: NSError?) -> ()) {
        AF.request(serviceType.URLString, method: serviceType.requestMethod, parameters: params, headers: nil).responseData { response in
            DispatchQueue.main.async() {
                switch response.result{
                case .success(let value):
                    completionBlock(value, nil)
                case .failure(let error):
                    print("error \(error)")
                    completionBlock(nil, error as NSError)
                }
            }
        }
    }
}
