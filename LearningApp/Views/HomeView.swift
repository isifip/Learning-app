//
//  ContentView.swift
//  LearningApp
//
//  Created by Irakli Sokhaneishvili on 11.12.21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                ScrollView {
                    LazyVStack {
                        VStack {
                            ForEach(model.modules) { module in
                                
                            
                                HomeViewRow(image: module.content.image,
                                            title: "Learn \(module.category)",
                                            description: module.content.description,
                                            count: "\(module.content.lessons.count) Lessons",
                                            time: module.content.time)
                                HomeViewRow(image: module.test.image,
                                            title: "Test \(module.category)",
                                            description: module.test.description,
                                            count: "\(module.test.questions.count) Lessons",
                                            time: module.test.time)
                                HomeViewRow(image: module.content.image,
                                            title: "Learn \(module.category)",
                                            description: module.content.description,
                                            count: "\(module.content.lessons.count) Lessons",
                                            time: module.content.time)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Get Started")
            
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
