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
        }.navigationBarHidden(true)
    }
    
    private var content: some View {
        switch store.state.showDetail.currentDetail {
        case .initial:
            return AnyView(initial())
        case .progress:
            return AnyView(progress())
        case .success(let details):
            if let details = details {
                return AnyView(tabView(details: details))
            }
            return AnyView(EmptyView())
        case .failure(_):
            return AnyView(EmptyView())
            
        }
    }
    
    private func initial() -> some View {
        Color.black
            .onAppear {
                store.dispatch(.showDetail(action: .loadShowDetailAndRelated(identifier: show.identifier, page: 1)))
            }
    }
    
    private func progress() -> some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ProgressView()
        }
    }
    
    private func tabView(details: [ShowDetail]) -> some View {
        TabView {
            ForEach(details, id: \.self) { show in
                ShowDetailView(show: show, configuration: store.state.images.configuration)
            }
        }
            .background(Color.black)
            .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct ShowDetailPagerView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailPagerView(show: Show.mock)
    }
}
