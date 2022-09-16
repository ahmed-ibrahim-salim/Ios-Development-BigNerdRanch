//
//  ItemStore.swift
//  BigNerdRanchProjects
//
//  Created by Ahmad medo on 15/09/2022.
//

import Foundation

class ItemStore {
    
    var allItems = [Item]()
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    func moveItem(fromIndex: Int, toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem, at: toIndex)
    }
    
}
