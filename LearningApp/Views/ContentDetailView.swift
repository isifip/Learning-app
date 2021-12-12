//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Irakli Sokhaneishvili on 12.12.21.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // Only show video if we get a valid url
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            // TODO: Description
            CodeTextView()
            
            // Show next lesson button, only if there is a next lesson
            if model.hasNextLesson() {
                Button {
                    // Advance the lesson
                    model.nextLesson()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(height: 48)
                        
                        
                        Text("Next lesson - \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color("randomColor"))
                            .bold()
                    }
                }
            }
        }
        .navigationTitle(lesson?.title ?? "")
        .padding()
    }
    
}

//struct ContentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentDetailView()
//            .environmentObject(ContentModel())
//    }
//}
