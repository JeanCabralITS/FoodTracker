//
//  Meal.swift
//  FoodTracker
//
//  Created by Jean Cabral on 1/22/18.
//  Copyright © 2018 Jean Cabral. All rights reserved.
//

import UIKit

class Meal{
    
    //MARK: Properties
    
    var name:String
    var photo: UIImage?
    var rating:Int
    
    // Failable Initializer. Fails if their is no name or if the rating is negative.
    
    init?(name: String, photo: UIImage?, rating: Int){
        // The name must not be empty. The guard statment declares a condition that must be true in order for code below the statment to execute.
        guard !name.isEmpty else{
            return nil
        }
        
        guard(rating >= 0) && (rating <= 5) else{
            return nil
        }
        
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
}
