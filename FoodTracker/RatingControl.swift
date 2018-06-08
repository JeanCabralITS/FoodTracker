//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Jean Cabral on 1/22/18.
//  Copyright © 2018 Jean Cabral. All rights reserved.
//

import UIKit

// Adding the @IBDesignable alllows you to see the programmatic elements coded in the Storyboard View. re-Build Project to see the changes/live preview

@IBDesignable class RatingControl: UIStackView {

    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0{
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    // Adds atrributes to the dsired properties inspector.
    @IBInspectable var starSize:CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButtons()
        
        
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton){
        
        
        // Get the index of the selected button
        guard let index = ratingButtons.index(of: button) else{
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating{
           // If the selected star represents the current rating, rset the rating to 0.
            rating = 0
            
        }else{
            
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    // MARK: Private Methods
    
    private func setupButtons(){
        
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of:self))
        let filledStar = UIImage(named: "filledStar", in:bundle , compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in:bundle , compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in:bundle , compatibleWith: self.traitCollection)
        
        
        for index in 0..<starCount{
            // Programmatically Creates a Button in this subview
            let button = UIButton()
            
            // Load the button images based on the state of the button.
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Disable auot-generated button constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            // Define the constarints for the height and width
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Sets the accesibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Add the button to the stack
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add button to the scene
            addArrangedSubview(button)
            ratingButtons.append(button)
            
        }
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated(){
            // if the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            // Set the hint String fro the currently selected star
            let hintString: String?
            if rating == index + 1{
                hintString = "Tap to reset the rating to zero"
            } else{
                hintString = nil
            }
            
            //Calculate the value string
            let valueString:String
            switch(rating){
            case 0:
                valueString = "No Rating Set."
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set."
                
                }
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
