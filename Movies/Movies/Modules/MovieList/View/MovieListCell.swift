



import SwiftUI

// Swift UI Cell
struct MovieListCell: View {
    private var movieImage: UIImage
    private var title: String
    private var subTitile: String
    
    init(movieImage: UIImage, title: String, subTitile: String) {
        self.movieImage = movieImage
        self.title = title
        self.subTitile = subTitile
    }
    var body: some View {
        VStack {
            Image(uiImage: movieImage)
                .resizable()
                .cornerRadius(10)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(1)
                .truncationMode(.tail)
        }
    }
}
