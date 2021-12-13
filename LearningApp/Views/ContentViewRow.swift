//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Irakli Sokhaneishvili on 11.12.21.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var lesson: Lesson {
        if model.currentModule != nil && index < model.currentModule!.content.lessons.count {
            return model.currentModule!.content.lessons[index]
        } else {
            return Lesson(id: 0, title: "", video: "", duration: "", explanation: "")
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 60)
                .cornerRadius(10)
                .shadow(radius: 5)
            HStack(spacing: 30) {
                Text("\(index + 1)")
                    .bold()
                VStack(alignment: .leading) {
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                }
            }
            .padding(.leading, 20)
            
        }
        .padding(.vertical, 5)
    }
}

