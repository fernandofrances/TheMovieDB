//
//  ShowDetailView.swift
//  TMDB
//
//  Created by Fernando Frances  on 28/3/22.
//

import SwiftUI

struct ShowDetailPagerView: View {
    
    @EnvironmentObject private var store: AppStore
    let show: Show
    
    @State private var currentPage = 0
    
    var body: some View {
        content.onDisappear {
            store.dispatch(.showDetail(action: .removeCurrentDetail))
        }
    }
    
    // First download similars
    // put all shows in an array
    // show the tab and let the detail download the detail show of each show.
    //!!
    
    private var content: some View {
        switch store.state.showDetail.currentSimilars {
        case .initial:
            return AnyView(Color.black
                .onAppear {
                    store.dispatch(.showDetail(action: .loadSimilars(identifier: show.identifier, page: 1)))
                })
            
        case .progress:
            return AnyView(ProgressView()
                .background(Color.black))
            
        case .success(let similars):
            var results = [show]
            results.append(contentsOf: similars?.results ?? [])
              return AnyView(
                TabView {
                    ForEach(results, id: \.self) { show in
                        ShowDetailView(show: show)
                    }
                }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .ignoresSafeArea()
              )
            
        case .failure(_):
            return AnyView(EmptyView())
            
        }
    }
}

struct ShowDetailPagerView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailPagerView(show: Show.mock)
    }
}
