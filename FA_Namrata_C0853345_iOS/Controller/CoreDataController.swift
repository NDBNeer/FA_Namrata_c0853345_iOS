//
//  CoreDataController.swift
//  FA_Namrata_C0853345_iOS
//
//  Created by Namrata Barot on 2022-05-30.
//

import UIKit
import CoreData


class CoreDataController{
    func storeSquareStates(){
        clearBoardStates()
        
    }
    func storePlayerStates(){
        clearPlayerStates()
    }
    func getSquareStates(){
        
    }
    func getPlayerStates(){
        
    }
    
    func clearBoardStates(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BoardState")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                        context.delete(result)
                }
            }
        } catch {
            print(error)
        }
    }
    func clearPlayerStates(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerState")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
            }
        } catch {
            print(error)
        }
    }
}
