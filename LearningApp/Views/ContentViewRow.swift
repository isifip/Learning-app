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
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(Color("randomColor"))
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

