//
//  AppDelegate.swift
//  InstaAuth
//
//  Created by Suzanne Niccolls on 28/02/17.
//  Copyright © 2016 Suzanne Niccolls. All rights reserved.
//

import UIKit
import SimpleAuth

class ViewController: UIViewController {
    
    typealias JSONDictionary = [String:Any]
    
    var user: InstagramUser?
    
    let INSTAGRAM_CLIENT_ID = "7ae7ef48a0c64bf99c2c5f13f616b991"
    let INSTAGRAM_REDIRECT_URI = "http://0.0.0.0:8080"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func connect(_ sender: Any) {
        connectInstagram()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Login" {
            let vc = segue.destination as! UITabBarController
            let exVC = vc.viewControllers!.first as! ExploreViewController
            exVC.user = user!
        }
    }

}

extension ViewController {
    
    func connectInstagram() {
        
        let auth: NSMutableDictionary = ["client_id": INSTAGRAM_CLIENT_ID,
                                         SimpleAuthRedirectURIKey: INSTAGRAM_REDIRECT_URI]
        
        SimpleAuth.configuration()["instagram"] = auth
        SimpleAuth.authorize("instagram", options: ["scope":["public_content"]]) { [unowned self] (result: Any?, error: Error?) -> Void in
            
            if let result = result as? JSONDictionary  {
                
                var token = ""
                var uid = ""
                var bio = ""
                var followed_by = ""
                var follows = ""
                var media = ""
                var username = ""
                var image = ""
                
                token = (result["credentials"] as! JSONDictionary)["token"] as! String
                uid = result["uid"] as! String
                
                if let extra = result["extra"] as? JSONDictionary,
                    let rawInfo = extra ["raw_info"] as? JSONDictionary,
                    let data = rawInfo["data"] as? JSONDictionary {
                    
                    bio = data["bio"] as! String
                    
                    if let counts = data["counts"] as? JSONDictionary {
                        followed_by = String(describing: counts["followed_by"]!)
                        follows = String(describing: counts["follows"]!)
                        media = String(describing: counts["media"]!)
                    }
                }
                
                if let userInfo = result["user_info"] as? JSONDictionary {
                    username = userInfo["username"] as! String
                    image = userInfo["image"] as! String
                }
                
                self.user = InstagramUser(token: token, uid: uid, bio: bio, followed_by: followed_by, follows: follows, media: media, username: username, image: image)
                
                
            } else {
                // this handles if user aborts or the API has a problem like server issue
                let alert = UIAlertController(title: "Error!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            if error != nil {
                print("Error during SimpleAuth.authorize: \(error)")
            }
          
            // User was successfully retrieved, so present the next view controller.
            self.performSegue(withIdentifier: "Login", sender: self)
            
//            let tab = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tab")
//            self.present(tab, animated: true, completion: nil)
          
        }
    }
}
