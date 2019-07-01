//
//  InfoViewModel.swift
//  GameOfThronesKata
//
//  Created by Oscar on 2019/01/21.
//  Copyright © 2019 Glucode. All rights reserved.
//

import Foundation
import UIKit

enum InfoViewModelItemType {
    case aboutCharacter
    case sibling
}

protocol InfoViewModelItem {
    
    var type: InfoViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
    
}

class InfoViewModel: NSObject {
    var items = [InfoViewModelItem]()
    
    override init() {
        super.init()
        
        guard let data = dataFromFile("character-detail-response"), let characterProfile = CharacterProfile(data: data) else {
            return
        }
        
        if let aboutCharacter = characterProfile.title, let status = characterProfile.status {
            let title = ProfileViewModelAboutItem(characterTitle: aboutCharacter, characterStatus: status)
            
            items.append(title)
        }
        
        let siblingsInfo = characterProfile.siblings
        if !siblingsInfo.isEmpty {
            
            let siblingsItem = ProfileViewModelSiblingsItem(siblings: siblingsInfo)
            
            items.append(siblingsItem)
        }
    }
}

extension InfoViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .aboutCharacter:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as? FirstTableViewCell {
                cell.item = item
                return cell
            }
        case .sibling:
            if let item = item as? ProfileViewModelSiblingsItem, let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as? SecondTableViewCell {
                cell.item = item.siblings[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}

class ProfileViewModelAboutItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .aboutCharacter
    }
    var sectionTitle: String {
        return "ABOUT THE CHARACTER"
    }
    
    var characterTitle: String
    var characterStatus: String
    
    init (characterTitle: String, characterStatus: String) {
        
        self.characterTitle = characterTitle
        self.characterStatus = characterStatus
    }
}

class ProfileViewModelSiblingsItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .sibling
    }
    var sectionTitle: String {
        return "SIBLINGS"
    }
    var rowCount: Int {
        return siblings.count
    }
    var siblings: [Sibling]
    init(siblings: [Sibling]) {
        self.siblings = siblings
    }
}

extension InfoViewModelItem {
    var rowCount: Int {
        return 1
    }
}
