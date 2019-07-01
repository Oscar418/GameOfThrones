//
//  InfoModel.swift
//  GameOfThronesKata
//
//  Created by Oscar on 2019/01/21.
//  Copyright © 2019 Glucode. All rights reserved.
//

import Foundation

public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        print("this is the json file \(path)")
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class CharacterProfile {
    
    var title: String?
    var status: String?
    var siblings = [Sibling]()
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
                self.title = body["title"] as? String
                self.status = body["status"] as? String
                
                if let siblings = body["siblings"] as? [[String: Any]] {
                    self.siblings = siblings.map { Sibling(json: $0) }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}

class AboutCharacter {
    
    var title: String?
    var status: String?
    
    init(json: [String: Any]) {
        self.title = json["title"] as? String
        self.status = json["status"] as? String
    }
}

class Sibling {
    
    var name: String?
    var dateOfBirth: String?
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String
        self.dateOfBirth = json["dateOfBirth"] as? String
    }
}
