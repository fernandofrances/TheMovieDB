//
//  ShowDetailView.swift
//  TMDB
//
//  Created by Fernando Frances  on 28/3/22.
//

import SwiftUI

struct ShowDetailView: View {
    
    let show: ShowDetail
    let configuration: Configuration
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                background(show: show, size: geometry.size)
                data(show: show, size: geometry.size)
                VStack {
                Rectangle()
                        .frame(width: geometry.size.width, height: 100)
                        .foregroundColor(.clear)
                   Spacer()
                }
            }
        }
        .ignoresSafeArea()
        .background(Color.black)
    }
    
    private func background(show: ShowDetail, size: CGSize) -> some View {
        VStack {
            AsyncImage(url: configuration.image(with: show.backdropPath ?? "", size: .w1280)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: size.width, height: size.height/2)
                        .clipped()
                        .id(show.identifier)
                } placeholder: {
                    Color.black
                }
            Spacer()
        }
    }
    
    private func data(show: ShowDetail, size: CGSize) -> some View {
        VStack {
            Color.clear.frame(width: size.width, height: 50)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ShowDetailHeaderView(show: show,
                                         configuration: configuration,
                                         size: size)
                    VStack {
                        Text(show.overview)
                            .font(.system(size: 20))
                            .foregroundColor(Color.element)
                            .multilineTextAlignment(.leading)
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
                    .background(Color.black)
                }
            }
            .padding(.bottom)
        }
    }
    
}

struct ShowDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        ShowDetailView(show: ShowDetail.mock, configuration: Configuration.default)
    }
}
