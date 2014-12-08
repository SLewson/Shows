import Foundation

class UserManagement {
    var auth_token: String = ""
    
    class func sendRequest(#username: String, password: String) {
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
        My API (2) (POST http://localhost:3000/users/sign_in)
        */
        
        var URL = NSURL(string: "http://localhost:3000/users/sign_in")
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "POST"
        
        // Form URL-Encoded Body
        
        let bodyParameters = [
            "user['password']": username,
            "user['email']": password,
            "commit": "Log In",
        ]
        let bodyString = self.stringFromQueryParameters(bodyParameters)
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        /* Start a new Task */
        let task = session.dataTaskWithRequest(request, completionHandler: { (data : NSData!, response : NSURLResponse!, error : NSError!) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as NSHTTPURLResponse).statusCode
                println("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                println("URL Session Task Failed: %@", error.localizedDescription);
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
