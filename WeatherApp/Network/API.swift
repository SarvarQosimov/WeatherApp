import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage

class API {
        
    static func getInfo (q: String, key: String, complition: @escaping(WeatherDM?) -> Void){
        var times = [String]()
        var temperatures = [String]()
        var hourlyIcons = [String]()
        
        let param: [String : Any] = [
            "q" : q ,
            "key" : key
        ]
        
        Net.request(parametr: param) { json in
            if let json = json {
                
                for i in json["forecast"]["forecastday"][0]["hour"].arrayValue {
                    times.append(String(i["time"].stringValue.dropFirst(11)))
                }
               
                for i in json["forecast"]["forecastday"][0]["hour"].arrayValue {
                   
                    var temp = ""
                    for i in i["temp_c"].stringValue.enumerated() {
                        if i.offset == 0 || i.offset == 1 && i.element != "."{
                            temp.append(i.element)
                        }
                    }
                
                    temperatures.append(temp)
                    
                }
               
                for i in json["forecast"]["forecastday"][0]["hour"].arrayValue {
                    hourlyIcons.append(i["condition"]["icon"].stringValue)
                }
                
                complition(
                    WeatherDM(
                        currentTemp: json["current"]["temp_c"].stringValue,
                        timeForHours: times,
                        timeTemp: temperatures,
                        regionName: json["location"]["name"].stringValue
                    )
                )
            } else {
                print("nill")
            }
        }
        
        
    }
    
}
