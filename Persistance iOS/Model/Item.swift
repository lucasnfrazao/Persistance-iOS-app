//
//  Item.swift
//  Persistance iOS
//
//  Created by Lucas Frazão on 13/10/21.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dataCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
