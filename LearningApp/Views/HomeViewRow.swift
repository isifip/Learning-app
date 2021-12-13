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
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 7)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
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
                        .multilineTextAlignment(.leading)
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
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "some description asfasf  safasfasfasfas asf asf asfasfasf 12", count: "10 Lessons", time: "2 Hours")
    }
}
