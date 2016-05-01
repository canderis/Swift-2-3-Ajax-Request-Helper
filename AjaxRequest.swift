//
//  AjaxRequest.swift
//  Server Connection Test
//
//  Created by Scott on 5/1/16.
//  Copyright © 2016 Canderis. All rights reserved.
//

import Foundation


func ajaxRequest( params: Dictionary<String, String>, url: String, success: (([String:AnyObject])->())? = nil, failure: ((String)->())? = nil ) {
    
    let nsurl = NSURL(string: url)
    
    // create post request
    let request = NSMutableURLRequest(URL: nsurl!)
    request.HTTPMethod = "POST"
    
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.setBodyContent(params)
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
        if error != nil{
            if failure == nil {
                print("Error -> \(error)")
                
            }
            else {
                dispatch_async(dispatch_get_main_queue(), {
                    failure!("\(error)")
                })
                
            }
            return
        }
        
        do {
            let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
            
            dispatch_async(dispatch_get_main_queue(), {
                success?(result!)
            })
            
        } catch {
            if failure == nil{
                print("Error -> \(error)")
            }
            else {
                dispatch_async(dispatch_get_main_queue(), {
                    failure!("\(error)")
                })
            }
            return
        }
    }
    
    task.resume()
}


extension NSMutableURLRequest {
    
    /// Populate the HTTPBody of `application/x-www-form-urlencoded` request
    ///
    /// - parameter parameters:   A dictionary of keys and values to be added to the request
    
    func setBodyContent(parameters: [String : String]) {
        let parameterArray = parameters.map { (key, value) -> String in
            return "\(key)=\(value.stringByAddingPercentEscapesForQueryValue()!)"
        }
        HTTPBody = parameterArray.joinWithSeparator("&").dataUsingEncoding(NSUTF8StringEncoding)
    }
}
extension String {
    
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    ///
    /// This percent-escapes all characters except the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// - returns:   Return precent escaped string.
    
    func stringByAddingPercentEscapesForQueryValue() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._~")
        return stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
}
