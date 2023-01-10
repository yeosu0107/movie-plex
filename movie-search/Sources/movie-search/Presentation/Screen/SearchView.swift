//
//  SearchView.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import SwiftUI

struct SearchView: View {
    @State private var keyword = ""
    @State private var movieList: Channel?
    @State private var isShowingAlert: Bool = false
    @State private var errorMsg: String = ""
    @Environment(\.injected) private var diContainer: DIContainer
    
    init() {
        self.movieList = nil
    }
    
    var body: some View {
        if #available(iOS 14.0, *) {
            NavigationView {
                BodyView()
                .navigationTitle("영화 검색")
                .navigationBarTitleDisplayMode(.large)
            }
            
        } else {
            NavigationView {
                BodyView()
                .navigationBarTitle("영화 검색", displayMode: .large)
            }
            
        }
    }
    
    func BodyView() -> some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("검색어", text: $keyword)
                Button("검색") {
                    Task {
                        await search()
                    }
                }.padding()
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            Spacer()
            
            VStack(alignment: .leading) {
                MovieListView(movieList: $movieList).inject(diContainer)
            }
            
            Spacer()
        }.alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Alert"), message: Text(errorMsg), dismissButton: .default(Text("OK")))
        }
    }
}

private extension SearchView {
    func search() async {
        do {
            movieList = try await diContainer.containers.searchMovieContainer.search(keyword: keyword)
        } catch {
            print(error)
            errorMsg = error.localizedDescription
            isShowingAlert = true
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().inject(.preview)
    }
}

