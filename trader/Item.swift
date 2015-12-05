//
//  Item.swift
//  trader
//
//  Created by Xi Zhang on 12/2/15.
//  Copyright © 2015 minor. All rights reserved.
//

import UIKit


class Item: NSObject, NSCoding{
    var id: Int;
    var name: String;
    var buyout: Int;
    var bid: Int;
    
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("items")
    
    
    struct PropertyKey {
        static let idKey = "id";
        static let nameKey = "name"
    }
    
    // MARK: Initialization
    init? (name: String? = nil, buyout: Int = 0, bid: Int = 0, id:Int = 0) {
        self.id = id;
        self.name = name == nil ? "id:" + String(id) : name!;
        self.buyout = buyout;
        self.bid = bid;
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Item {
            return id == object.id;
        } else {
            return false;
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(id, forKey: PropertyKey.idKey);
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey);
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeIntegerForKey(PropertyKey.idKey);
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as? String;
        self.init(id: id, name: name);
    }

}
