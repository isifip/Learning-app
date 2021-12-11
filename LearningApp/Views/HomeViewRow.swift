//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by Irakli Sokhaneishvili on 11.12.21.
//

import SwiftUI

struct HomeViewRow: View {
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("randomColor"))
                .cornerRadius(20)
                .shadow(radius: 10)
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        //.font(.title3)
                        .bold()
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    HStack {
                        Image(systemName: "text.book.closed")
                            .font(.callout)
                        Text(count)
                            .font(.caption)
                    Spacer()
                        Image(systemName: "clock")
                            .font(.callout)
                        Text(time)
                            .font(.caption)
                    }
                }
                .padding(.leading, 20)
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .frame(height: 220)
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "some description asfasf  safasfasfasfas asf asf asfasfasf fasf ff", count: "10 Lessons", time: "2 Hours")
    }
}
