import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage

let baseURL = "https://api.weatherapi.com/v1"

class Net {
        
    static func request(parametr: Parameters,method: HTTPMethod = .get, complition: @escaping(JSON?) -> Void){
        
        AF.request(baseURL+"/forecast.json?",method: method,parameters: parametr).response { [self] json in
            if let data = json.data {
                let json = JSON(data)
                complition(json)
            } else {
                print("nill keldi")
            }
                        
        }
        
    }
    
}
