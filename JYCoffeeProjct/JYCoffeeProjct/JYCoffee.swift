//
//  JYCoffee.swift
//  JYCoffeeProjct
//
//  Created by atom on 16/2/25.
//  Copyright © 2016年 cyin. All rights reserved.
//


import QuadratTouch

import RealmSwift

import MapKit

extension CLLocation {
    
    func parameters() -> Parameters {
        
        let ll = "\(self.coordinate.latitude),\(self.coordinate.longitude)"
        
        let llAcc = "\(self.horizontalAccuracy)"
        
        let alt = "\(self.altitude)"
        
        let altAcc = "\(self.verticalAccuracy)"
        
        let parametrs = [
            
            Parameter.ll: ll,
            
            Parameter.llAcc: llAcc,
            
            Parameter.alt: alt,
            
            Parameter.altAcc: altAcc
        
        ]
        
        return parametrs
        
    }

}

struct API {
    
    struct notifications {
        
        static let venusUpdated = "venues updated"
    }
}

class CoffeeAPI {
    
    static let sharedInstance = CoffeeAPI()
    
    var session: Session?
    
    init() {
        
        let client = Client(clientID: "C0VIUAMJCTISASIUOIYHDJ1LXHVTTAQQBK3WLZBFYWUU425I", clientSecret: "X0PR5IOR5Q0EU0U2XLMXUBYTK1ACCJQABRRE12NRXARZKANC", redirectURL: "")
        
        let configuration = Configuration(client: client)
        
        Session.setupSharedSessionWithConfiguration(configuration)
        
        self.session = Session.sharedSession()
        
        
    
    }
    
    func getCoffeeShopWithLocation(location: CLLocation) {
    
        if let session = self.session {
            
            var jyparameters = location.parameters()
            
            jyparameters += [Parameter.categoryId: "55eacd22498ece8f36299112"]
            
            jyparameters += [Parameter.radius: "2000"]
            
            jyparameters += [Parameter.limit: "50"]
            
            
            let searchTask = session.venues.search(jyparameters, completionHandler: { (result) -> Void in
                
                if let response = result.response {
                    
                    if let venus = response["venues"] as? [[String: AnyObject]]{
                        
                        autoreleasepool {
                            
                            let realm = try! Realm()
                            
                            realm.beginWrite()
                            
                            for venue: [String: AnyObject] in venus {
                                
                                let venueObject: Venue = Venue()
                                
                                if let id = venue["id"] as? String {
                                    
                                    venueObject.id = id
                                
                                }
                                
                                if let name = venue["name"] as? String {
                                    
                                    venueObject.name = name
                                
                                }
                                
                                if let location = venue["location"] as? [String: AnyObject] {
                                    
                                    if let longitude = location["lng"] as? Float {
                                        
                                        venueObject.longitude = longitude
                                    
                                    }
                                    
                                    if let latitude = location["lat"] as? Float {
                                        
                                        venueObject.latitude = latitude
                                    
                                    }
                                    
                                    if let formattedAddress = location["formattedAddress"] as? [String] {
                                        
                                        venueObject.address = formattedAddress.joinWithSeparator(" ")
                                    
                                    }
                                
                                }
                                
                                realm.add(venueObject)
                            
                            }
                            
                            do {
                            
                                try realm.commitWrite()
                                
                                print("Committing write...")
                                
                            } catch (let e) {
                                
                                print("Y U NO Ralm? \(e)")
                            
                            }
                        
                        }
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(API.notifications.venusUpdated, object: nil, userInfo: nil)
                    
                    }
                
                }
                
            })
            
            searchTask.start()
        }
    
    
    
    }
}