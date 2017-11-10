//
//  Artist.swift
//  017-self-sizing-table-view-cells
//
//  Created by  moma on 2017/11/9.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

struct Artist: Codable {
    var name: String
    var bio: String
    var image: String
    var works: [Work] 
    
    static func artistsFromBundle() -> [Artist] {
        var artists = [Artist]()
        
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return artists
        }
        do {
            let data = try Data(contentsOf: url)
            let artistsDic = try JSONDecoder().decode([String:[Artist]].self, from: data)
            if let artistsArray = artistsDic["artists"] {
                artists = artistsArray
            }
        } catch {
            print("JSON Error: \(error)")
            return artists
        }
        
        return artists
    }
}

struct Work: Codable {
    var title: String
    var image: String
    var info: String
    var isExpanded: Bool?
    
}

