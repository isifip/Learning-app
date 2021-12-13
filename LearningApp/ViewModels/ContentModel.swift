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
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    // Current quetion
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    // Current lesson explanation
    @Published var codeText = NSAttributedString()
    
    var styleData: Data?
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    init() {
        // Parse local included json data
        getLocalData()
        //Download remote JSON and parse data
        getRemoteData()
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
    
    func getRemoteData() {
        let urlString = "https://codewithchris.github.io/learningapp-data/data2.json"
        let url = URL(string: urlString)
        guard url != nil else {
            // Couldnt create url
            return
        }
        // Create a URLRequest object
        let request = URLRequest(url: url!)
        // Get the Session and kick off the task
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            // Check if there is an error
            guard error == nil else {
                // there was an error
                return
            }
            do {
                // handle the response
                let decoder = JSONDecoder()
                // Decode
                let modules = try decoder.decode([Module].self, from: data!)
                DispatchQueue.main.async {
                    //Append parsed modules into modules
                    self.modules += modules
                }
               
            } catch {
                print(error)
            }
        }
        // kick off data task
        dataTask.resume()
    }
    
    //MARK: --> Module Navigation Methods
    func beginModule(_ moduleId: Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                // Found matching module
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
        
        
    }
    
    func beginLesson(_ lessonIndex: Int) {
        // check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[lessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        
        guard currentModule != nil else {
            return false
        }
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        } else {
            return false
        }
    }
    
    func nextLesson() {
        // Advance the lesson index
        currentLessonIndex += 1
        
        // check that it is within the range
        if currentLessonIndex < currentModule!.content.lessons.count {
            //set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            // Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
            
        }
    }
    
    func beginTest(_ moduleId: Int) {
        // set the current module
        beginModule(moduleId)
        // set the current question
        currentQuestionIndex = 0
        // if there are question, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            // Set the question content
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    
    func nextQuestion() {
        // Advance the question index
        currentQuestionIndex += 1
        // check that its within the range of question
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        } else {
            // if not, then reset the properties
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    //MARK: --> Code styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        // add the styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // add the html data
        data.append(Data(htmlString.utf8))
        // Convert to attributed String
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            resultString = attributedString
        }
        catch {
            print("Couldn't turn html into attributed string")
        }
        return resultString
    }
}
