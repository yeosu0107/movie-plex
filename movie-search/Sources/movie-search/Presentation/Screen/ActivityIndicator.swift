//
//  ActivityIndicator.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/11.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    
    func updateUIView(_ uiView: UIView, context:UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() :uiView.stopAnimating()
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(isAnimating: true)
    }
}
