//
//  Category.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 13/10/21.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var emoji : String = "🤯"
    let items = List<Item>()
    
}
