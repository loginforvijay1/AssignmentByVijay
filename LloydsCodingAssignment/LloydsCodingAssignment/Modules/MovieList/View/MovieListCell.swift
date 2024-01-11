//
//  MovieListCell.swift
//  LloydsCodingAssignment
//
//  Created by Vemireddy Vijayasimha Reddy on 11/01/24.
//

import Foundation
import SwiftUI

// Swift UI Cell
struct MovieListCell: View {
    var movieImage: UIImage
    var title: String
    var subTitile: String
    var body: some View {
        ZStack() {
            Image(uiImage: movieImage)
                .scaledToFit()
            VStack {
                Spacer()
                HStack{
                    Text(subTitile)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .background(.black).opacity(0.8)
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .bold))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .border(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 0, leading: 55, bottom: 0, trailing: 3))
                    Spacer()
                }
                Spacer()
                Spacer()
                Text(title)
                    .background(.black).opacity(0.6)
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .bold))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .border(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Spacer()
                
            }
        }
        
    }
}
