//
//  SearchView.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import SwiftUI

struct SearchView: View {
    @State private var keyword = ""
    
    var body: some View {
        NavigationTitleViews {
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("검색어", text: $keyword)
                    Button("검색") {
                        search()
                    }.padding()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("HelloWorld")
                }
                
                Spacer()
            }
        }
    }
    
    func NavigationTitleViews(content: ()-> some View) -> some View {
        if #available(iOS 14.0, *) {
            return NavigationView{
                content()
            }
            .navigationTitle("영화 검색")
            .navigationBarTitleDisplayMode(.automatic)
        } else {
            return NavigationView{
                content()
            }
            .navigationBarTitle("영화 검색", displayMode: .automatic)
        }
    }
}

private extension SearchView {
    func search() {
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

