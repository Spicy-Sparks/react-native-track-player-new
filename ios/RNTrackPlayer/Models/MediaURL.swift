//
//  MediaURL.swift
//  RNTrackPlayer
//
//  Created by David Chavez on 12.08.17.
//  Copyright © 2017 David Chavez. All rights reserved.
//

import Foundation
import React

struct MediaURL {
    let value: URL
    let isLocal: Bool
    private let originalObject: Any
    
    init?(object: Any?) {
        guard let object = object else { return nil }
        originalObject = object
        
        if let localObject = object as? [String: Any] {
            let uri = localObject["uri"] as! String
            isLocal = uri.lowercased().contains("http") ? false : true
            let encodedURI = uri.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            value = RCTConvert.nsurl(encodedURI.replacingOccurrences(of: "file://", with: ""))
        } else {
            let url = object as! String
            isLocal = url.lowercased().contains("http") ? false : true
            value = RCTConvert.nsurl(url.replacingOccurrences(of: "file://", with: ""))
        }
    }
}
