//
//  TopRatedView.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import SwiftUI

struct TopRatedView: View {
    
    @EnvironmentObject private var store: AppStore
    
    var showColumns: [GridItem] {
        [GridItem(.flexible(minimum: 150)),
         GridItem(.flexible(minimum: 150))]
    }
    
    var body: some View {
        loadableContent
    }
    
    private var loadableContent: some View {
        switch store.state.topRated.topRated {
        case .initial:
            return AnyView(EmptyView())
        case .progress:
            return AnyView(ProgressView())
        case .success(let topRated):
            if let page = topRated {
                return AnyView(topRatedGrid(shows: page.results))
            }
            return AnyView(EmptyView())
        case .failure(_):
            return AnyView(EmptyView())
        }
    }
    
    private func topRatedGrid(shows: [Show])-> some View {
        AnyView(
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Top Rated Shows")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            Spacer()
                        }
                        LazyVGrid(columns: showColumns) {
                            ForEach(shows, id: \.self) { show in
                                ShowCardView(show: show,
                                             configuration: store.state.images.configuration,
                                             width: geometry.size.width/2 - 20)
                                    .onTapGesture {
                                        store.dispatch(.topRated(action: .selectShow(show)))
                                    }
                            }
                        }
                    }
                }
            }
                .background(Color.black)
                .sheet(isPresented: $store.state.topRated.showSelected,
                       onDismiss: {
                           store.dispatch(.topRated(action: .deselectShow))
                       }, content: {
                           if let show = store.state.topRated.selectedShow {
                               ShowDetailPagerView(show: show)
                           }
                       })
        )
    }
    
}

struct TopRatedView_Previews: PreviewProvider {
    
    static var previews: some View {
        TopRatedView()
            .environmentObject(AppStore(initial: AppState(topRated: TopRatedState(topRated: Loadable.success(Page.mock)), showDetail: ShowDetailState(), images: ImagesState()), reducer: appReducer))
    }
}
