//
//  CodeTextView.swift
//  LearningApp
//
//  Created by Irakli Sokhaneishvili on 12.12.21.
//

import SwiftUI

struct CodeTextView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    func makeUIView(context: Context) -> some UITextView {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }

    func updateUIView(_ textView: UIViewType, context: Context) {
        
        textView.attributedText = model.lessonDescription
        // Scroll back to top
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
