//
//  ShowDetailHeaderView.swift
//  TMDB
//
//  Created by Fernando Frances  on 28/3/22.
//

import SwiftUI

struct ShowDetailHeaderView: View {
    
    let show: ShowDetail
    let configuration: Configuration
    let size: CGSize
    
    var body: some View {
        header(show: show, size: size)
    }
    
    private func header(show: ShowDetail, size: CGSize) -> some View {
        ZStack {
            headerBackdropLayer(show: show, size: size)
            headerGradientLayer()
            headerTextLayer(show: show)
        }.frame(height: size.height/2)
    }
    
    private func headerBackdropLayer(show: ShowDetail, size: CGSize) -> some View {
        AsyncImage(url: configuration.image(with: show.backdropPath ?? "", size: .w1280))
        { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height/2)
                    .clipped()
            } placeholder: {
                Color.black
            }
    }
    
    private func headerGradientLayer() -> some View {
            LinearGradient(
                gradient: Gradient(
                    stops: [.init(color: .black, location: 0),
                            .init(color: .black, location: 0.1),
                            .init(color: .clear, location: 1)]
                ),
                startPoint: .bottomLeading,
                endPoint: .topLeading
            )
    }
    
    private func headerTextLayer(show: ShowDetail) -> some View {
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(show.genres.first?.name ?? "")
                                .font(.system(size: 12))
                                .foregroundColor(.element)
                                .bold()
                            Text(show.name)
                                .font(.system(size: 30))
                                .bold()
                                .foregroundColor(.element)
                        }
                        Spacer()
                        Text(String(show.vote))
                            .foregroundColor(Color.element)
                            .background(
                                Circle()
                                    .fill(Color.black)
                                    .northWestShadow()
                                    .frame(width: 60, height: 60)
                            )
                            .frame(width: 60, height: 60)
                            .padding(.vertical)
                    }
                }
                Spacer()
            }.padding()
    }
    
}

struct ShowDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailHeaderView(show: ShowDetail.mock,
                             configuration: Configuration.default,
                             size: CGSize(width: 200, height: 500))
            .frame(width: 400)
            .previewLayout(.sizeThatFits)
    }
}
