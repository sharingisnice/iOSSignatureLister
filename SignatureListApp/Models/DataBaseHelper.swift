//
//  DataBaseHelper.swift
//  SignatureListApp
//
//  Created by Mert Ejder 2  on 7.03.2021.
//

import Foundation
import UIKit
import CoreData

class DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveImage(data: Data, date: String) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
        imageInstance.date = date
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func fetchImage() -> [Image] {
        var fetchingImage = [Image]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Image]
        } catch {
            print("Error while fetching the image")
        }
        return fetchingImage
    }
    
    
    func deleteImage(data: Image) {
        do {
            try context.delete(data)
            try context.save()
            print("removed item and saved state")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
