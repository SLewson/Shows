import Foundation

class UserManagement {
    
    class func setAuthToken(authToken: String) {
        NSUserDefaults.standardUserDefaults().setValue(authToken, forKey: "AUTH_TOKEN")
    }
    
    class func getAuthToken() -> String? {
        if let token = NSUserDefaults.standardUserDefaults().valueForKey("AUTH_TOKEN") as? String {
            return token
        }
        else {
            return nil
        }
    }
    
    class func isLoggedIn() -> Bool {
        // I'm suspicious of this...
        return getAuthToken() != nil
    }
    
    class func loginWith(#username: String, password: String, completionHandler: (success: Bool)->()) {
        /* Configure session, choose between:
        * defaultSessionConfiguration
        * ephemeralSessionConfiguration
        * backgroundSessionConfigurationWithIdentifier:
        And set session-wide properties, such as: HTTPAdditionalHeaders,
        HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
        */
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        /* Create session, and optionally set a NSURLSessionDelegate. */
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
        Login (GET http://localhost:3000/bad_login)
        */
        
        var URL = NSURL(string: "http://localhost:3000/bad_login")
        let URLParams = [
            "email": username,
            "password": password,
        ]
        URL = self.NSURLByAppendingQueryParameters(URL, queryParameters: URLParams)
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        
        /* Start a new Task */
        let task = session.dataTaskWithRequest(request, completionHandler: { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as NSHTTPURLResponse).statusCode
                println("URL Session Task Succeeded: HTTP \(statusCode)")
                
                var error: NSError?
                if let response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                    if let success = response.objectForKey("success") {
                        // If success is here, login failed
                        if let success_bool = success as? Bool {
                            completionHandler(success: success_bool)
                        }
                        else {
                            completionHandler(success: false)
                        }
                    }
                    else {
                        // Login successful
                        if let authtok = response.objectForKey("authentication_token") {
                            if let authtok_string = authtok as? String {
                                self.setAuthToken(authtok_string)
                                completionHandler(success: true)
                            }
                            else {
                                completionHandler(success: false)
                            }
                        }
                        else {
                            completionHandler(success: false)
                        }
                    }
                }
            }
            else {
                // Failure
                println("URL Session Task Failed: %@", error.localizedDescription);
                completionHandler(success: false)
            }
        })
        task.resume()
    }
    
    /**
    This creates a new query parameters string from the given NSDictionary. For
    example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
    string will be @"day=Tuesday&month=January".
    @param queryParameters The input dictionary.
    @return The created parameters string.
    */
    class func stringFromQueryParameters(queryParameters : Dictionary<String, String>) -> String {
        var parts: [String] = []
        for (name, value) in queryParameters {
            var part = NSString(format: "%@=%@",
                name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!,
                value.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
            parts.append(part)
        }
        return "&".join(parts)
    }
    
    /**
    Creates a new URL by adding the given query parameters.
    @param URL The input URL.
    @param queryParameters The query parameter dictionary to add.
    @return A new NSURL.
    */
    class func NSURLByAppendingQueryParameters(URL : NSURL!, queryParameters : Dictionary<String, String>) -> NSURL {
        let URLString : NSString = NSString(format: "%@?%@", URL.absoluteString!, self.stringFromQueryParameters(queryParameters))
        return NSURL(string: URLString)!
    }
}
