//
//  Artist.swift
//  GregsonRaevan_CE2
//
//  Created by Raevan Gregson on 11/29/16.
//  Copyright © 2016 Raevan Gregson. All rights reserved.
//

import Foundation
import UIKit

class Artist{

    var name: String?
    var genre: String?
    var albums: Int?
    var image:UIImage?
    
    
    
    init(name: String, genre: String, albums: Int, image: UIImage) {
        self.name = name
        self.genre = genre
        self.albums = albums
        self.image = image
    }

}
