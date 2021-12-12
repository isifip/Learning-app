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
                        ForEach(model.modules) { module in
                            VStack() {
                                NavigationLink {
                                    ContentView()
                                        .onAppear {
                                            model.beginModule(module.id)
                                        }
                                } label: {
                                    // Learning card
                                    HomeViewRow(image: module.content.image,
                                                title: "Learn \(module.category)",
                                                description: module.content.description,
                                                count: "\(module.content.lessons.count) Lessons",
                                                time: module.content.time)
                                }
                                HomeViewRow(image: module.test.image,
                                            title: "Test \(module.category)",
                                            description: module.test.description,
                                            count: "\(module.test.questions.count) Lessons",
                                            time: module.test.time)
                            }
                        }
                    }
                    .tint(.black)
                    .padding()
                }
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
