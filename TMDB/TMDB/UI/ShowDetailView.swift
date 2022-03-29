//
//  ShowDetailView.swift
//  TMDB
//
//  Created by Fernando Frances  on 28/3/22.
//

import SwiftUI

struct ShowDetailView: View {
    
    @EnvironmentObject private var store: AppStore
    
    let show: Show
    
    var body: some View {
        loadableContent
    }
    
    private var loadableContent: some View {

        switch store.state.showDetail.currentDetail {
        case .initial:
            return AnyView(
                Color.black
                .onAppear {
                    store.dispatch(.showDetail(action: .loadDetail(identifier: show.identifier)))
                })
        case .progress:
            return AnyView(ProgressView())
        case .success(let show):
            if let show = show {
                return AnyView(showDetailView(show: show))
            }
            return AnyView(EmptyView())
        case .failure(_):
            return AnyView(EmptyView())
        }
    }
    
    private func showDetailView(show: ShowDetail)-> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ShowDetailHeaderView(show: show,
                                         configuration: store.state.images.configuration,
                                         size: geometry.size)
                    data(show: show)
                }
            }
        }
        .ignoresSafeArea()
        .background(Color.black)
        .onDisappear {
            store.dispatch(.showDetail(action: .removeCurrentDetail))
        }
    }
    
    private func data(show: ShowDetail) -> some View {
            VStack {
                Text(show.overview)
                    .font(.system(size: 20))
                    .foregroundColor(Color.element)
                    .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(show.episodes) episodes")
                            .font(.system(size: 18))
                            .foregroundColor(Color.element)
                        Text("released on \(show.releaseDate)")
                            .font(.system(size: 18))
                            .foregroundColor(Color.element)
                    }
                    Spacer()
                }.padding(20)
            }
    }
    
}

struct ShowDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        ShowDetailView(show: Show.mock)
    }
}
