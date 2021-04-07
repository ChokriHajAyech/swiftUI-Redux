import SwiftUI

struct URLImage: View {
    
    let url: String
    let placeholder: String
	
    @ObservedObject var imageLoader = ImageLoader()
    
    init(url: String, placeholder: String = "placeholder") {
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.downloadImage(url: self.url)
    }
    
    var body: some View {
        if let data = self.imageLoader.downloadedData {
            return Image(uiImage: UIImage(data: data)!)
				.resizable()
				.aspectRatio(contentMode: .fit)
				//.frame(maxWidth: .infinity, maxHeight: .infinity)
				.aspectRatio(16.0 / 9.0, contentMode: .fit)
        } else {
            return Image(placeholder)
				.resizable()
				.aspectRatio(contentMode: .fit)
				//.frame(maxWidth: .infinity, maxHeight: .infinity)
				.aspectRatio(16.0 / 9.0, contentMode: .fit)
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "https://fyrafix.files.wordpress.com/2011/08/url-8.jpg")
    }
}
