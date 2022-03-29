//
//  ShowCardView.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import SwiftUI

struct ShowCardView: View {
    
    var show: Show
    var configuration: Configuration
    var width: CGFloat
    let height: CGFloat = 250
    
    var body: some View {
        ZStack {
            imageLayer
            gradientLayer
            textLayer
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .frame(width: width, height: height)
        .northWestShadow()
    }
    
    private var imageLayer: some View {
        AsyncImage(url: configuration.image(with: show.posterPath ?? "", size: .w300)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
        } placeholder: {
            ProgressView()
        }
    }
    
    private var gradientLayer: some View {
        LinearGradient(
            gradient: Gradient(
                stops: [.init(color: .black, location: 0),
                        .init(color: .black, location: 0.3),
                        .init(color: .clear, location: 1)]
            ),
            startPoint: .bottomLeading,
            endPoint: .topLeading
        )
            .opacity(0.85)
    }
    
    private var textLayer: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                Text(Genre.name(forIdentifier: show.genreIdentifiers?.first ?? 0) ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.element)
                    .bold()
                Text(show.title)
                    .font(.system(size: 20))
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.element)
            }
            Spacer()
        }.padding()
    }
    
}

struct ShowCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        ShowCardView(show: Show.mock,
                     configuration: Configuration.default,
                     width: 180)
    }
}
