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
            return AnyView(Color.black
                            .onAppear {
                store.dispatch(.showDetail(action: .loadShowDetailAndRelated(identifier: show.identifier, page: 1)))
            })
            
        case .progress:
            return AnyView(
                ZStack {
                    Color.black
                    ProgressView()
                }
            )
               
        case .success(let details):
            if let details = details {
                return AnyView(
                    TabView {
                        ForEach(details, id: \.self) { show in
                            ShowDetailView(show: show, configuration: store.state.images.configuration)
                        }
                    }
                        .background(Color.black)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                )
            }
            return AnyView(EmptyView())
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
