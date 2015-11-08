//
//  RailsRequest.swift
//  RailsRequest
//
//  Created by alex oh on 11/5/15.
//  Copyright © 2015 Alex Oh. All rights reserved.
//

import UIKit

private let _rr = RailsRequest()
private let _d = NSUserDefaults.standardUserDefaults()

class RailsRequest: NSObject {

    class func session() -> RailsRequest { return _rr }
    
    var token: String? {
        
        get { return _d.objectForKey("token") as? String }
        
        set { _d.setObject(newValue, forKey: "token") }
        
    }
    
    var userName: String?
    var user_id: Int?
        
    
    func loginWithUsername(username: String, andPassword password: String) {
        
        var info = RequestInfo()
        
        info.endpoint = "/users/login"
        info.method = .POST
        info.parameters = [
        
            "username" : username,
            "password" : password
            
        ]
    
        requestWithInfo(info) { (returnedInfo) -> () in
            
            // here we grab the access token & user id and save them
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                if let key = user["access_key"] as? String {
                    
                    self.token = key
                    
                    print(self.token)
                    
                }
                
                if let myUsername = user["username"] as? String {
                    
                    self.userName = myUsername
                    
                    print(self.userName)
                    
                }
                
                if let myUserID = user["user_id"] as? Int {
                    
                    self.user_id = myUserID
                    
                    print(self.user_id)
                    
                }
                
            }
            
            if let errors = returnedInfo?["errors"] as? [String] {
                
                // look through errors
                print(errors[0])
                
            }
            

            
        }

    }
    
    func registerWithUsername(username: String, FullName fullname: String, Email email: String, Password password: String) {
        
        // have to make sure email is in text@text.text format!!!
        // texting against string regex for email
        
        var info = RequestInfo()
        
        info.endpoint = "/users/register"
        info.method = .POST
        info.parameters = [
        
            "username" : username,
            "fullname" : fullname,
            "email" : email,
            "password" : password
            
        ]
        
        requestWithInfo(info) { (returnedInfo) -> () in
            
            if let user = returnedInfo?["user"] as? [String:AnyObject] {
                
                if let key = user["access_key"] as? String {
                    
                    self.token = key
                    
                    print(self.token)
                    
                    // these are all optional
                    
                }
                
                if let myUserID = user["user_id"] as? Int {
                    
                    self.user_id = myUserID
                    print(self.user_id)
                    
                }
                
                
                
            }
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    private let baseURL = "https://guarded-ridge-7410.herokuapp.com"
    
    func requestWithInfo(info: RequestInfo, completion: (returnedInfo: AnyObject?) -> ()) {
        
        var fullURLString = baseURL + info.endpoint
        
        // add query : number 3
        
        for (i,(k,v)) in info.query.enumerate() {
            
            if i == 0 { fullURLString += "?" } else { fullURLString += "&" }
            
            fullURLString += "\(k)=\(v)"
            
        }
                
        guard let url = NSURL(string: fullURLString) else {return} // add run completion with fail
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = info.method.rawValue
        
        // add token if we have one
        
        if let token = token {
            
            request.setValue(token, forHTTPHeaderField: "Access-Key")
            
        }
        
        // add parameters to body
        
        // number 4
        if info.parameters.count > 0 {
            
            if let requestData = try? NSJSONSerialization.dataWithJSONObject(info.parameters, options: .PrettyPrinted) {
                
                
                if let jsonString = NSString(data: requestData, encoding: NSUTF8StringEncoding) {
                    
                    request.setValue("\(jsonString.length)", forHTTPHeaderField: "Content-Length")
                    
                    let postData = jsonString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                    
                    request.HTTPBody = postData
                    
                }
                
            }
            
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        // creates a task from request
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            // works with the data returned
            
            if let data = data {
                
                // have data
                
                // making the data from task, into an array
                if let returnedInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) {
                    
                    completion(returnedInfo: returnedInfo)
                    
                }
                
                
            } else {
                
                // no data: check if error is not nil
                
            }
            
        }

        // runs the task (makes the request call)
        task.resume()
        
    }
    
}

struct RequestInfo {
    
    enum MethodType: String {
        
        case POST, GET, DELETE
        
    }
    
    var endpoint: String!
    var method: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
    var query: [String:AnyObject] = [:] /// number 1
    
}