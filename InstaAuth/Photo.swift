//
//  Photo.swift
//  InstaAuth
//
//  Created by Suzanne Niccolls (i7246000) on 22/03/2017.
//  Copyright © 2017 David Seek. All rights reserved.
//

import Foundation


class Photo {
    
    var caption: String!
    var imageUrl: String!
    
    
    init(data: [String : Any]) {

        let captionData = data["caption"] as! [String: Any]
        caption = captionData["text"] as! String

        getImage(imageData: data["images"] as! [String: Any])
        
    }
    
    func getImage(imageData: [String: Any]) {
        let sdData = imageData["standard_resolution"] as! [String: Any]
        imageUrl = sdData["url"] as! String
    }
    
    
}
