//
//  ContentModel.swift
//  LearningApp
//
//  Created by Irakli Sokhaneishvili on 11.12.21.
//

import Foundation
import SwiftUI

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }

    //MARK: --> Data Methods
    func getLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            self.modules = modules
        } catch {
            print("Couldn't parse local JSON data")
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        } catch {
            print("Couldn't parse local style data.")
        }
    }
    
    //MARK: --> Module Navigation Methods
    func beginModule(_ moduleid: Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                // Found matching module
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
        
    }
    
}
