//
//  ViewController.swift
//  Project1
//
//  Created by Batchu Lakshmi Alekhya on 10/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    var searchField: UITextField!
    var index = 0
    let listOfPlaceholders: [String] = [
        "Search for offers...",
        "Search for Brands...",
        "Search for Products...",
        "Search here..."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the text field
        searchField = UITextField()
        searchField.borderStyle = .roundedRect
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.textColor = UIColor.gray.withAlphaComponent(0.5)
        searchField.tintColor = UIColor.gray.withAlphaComponent(0.5)
        searchField.becomeFirstResponder()
        
        // Create the search icon image view
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .gray
        searchIcon.contentMode = .scaleAspectFit
        
        // Add padding to the image view
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        searchIcon.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        paddingView.addSubview(searchIcon)
        
        // Set the image view as the left view of the text field
        searchField.leftView = paddingView
        searchField.leftViewMode = .always
        
        view.backgroundColor = .orange
        
        // Add the text field to the view
        view.addSubview(searchField)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchAction), for: .allEvents)
        
        view.addSubview(button)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add constraints to position the button on top of the text field
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: searchField.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // call this method to update the placeholder
        self.setupPlaceHolder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchField.layer.shadowColor = UIColor.black.cgColor
        searchField.layer.shadowOffset = CGSize(width: 0, height: 2)
        searchField.layer.shadowOpacity = 0.5
        searchField.layer.shadowRadius = 4.0
        searchField.layer.masksToBounds = false
    }
    
    func setupPlaceHolder() {
        // Step 1: Define the placeholder text from the list using the current index
        let placeholderText = listOfPlaceholders[index]
        var currentIndex = 0
        
        // Step 2: Start a timer that fires every 0.2 seconds
        _ = Timer.scheduledTimer(
            withTimeInterval: 0.2,
            repeats: true
        ) { [weak self] timer in
            // Step 3: Safely unwrap self
            guard let self = self else {
                return
            }
            
            // Step 4: If currentIndex is less than the length of the placeholder text
            if currentIndex < placeholderText.count {
                // Get the character at the current index
                let index = placeholderText.index(placeholderText.startIndex, offsetBy: currentIndex)
                // Append the character to the search field's text
                self.searchField.text?.append(placeholderText[index])
                // Increment currentIndex
                currentIndex += 1
            } else {
                // Step 5: Invalidate the timer once the entire placeholder text is displayed
                timer.invalidate()
                // After a 2-second delay, remove the placeholder text if needed
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                    if self.index < self.listOfPlaceholders.count - 1 {
                        self.removePlaceholder(placeholderText: placeholderText)
                    }
                }
            }
        }
    }
    
    func removePlaceholder(placeholderText: String) {
        // Step 1: Initialize the index to the length of the placeholder text
        var index = placeholderText.count
        
        // Step 2: Start a timer that fires every 0.1 seconds
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] timer in
            // Step 3: If index is greater than 0, remove the last character of the text field's text
            if index > 0 {
                self.searchField.text?.removeLast()
                index -= 1
            } else {
                // Step 4: Invalidate the timer once all characters are removed
                timer.invalidate()
                // Increment the index to move to the next placeholder
                self.index += 1
                // Step 5: If there are more placeholders in the list, set up the next placeholder
                if self.index < listOfPlaceholders.count {
                    setupPlaceHolder()
                }
            }
        }
    }
    
    @objc func searchAction() {
        // add search action on tap of search field
        print("Search clicked")
    }
}

