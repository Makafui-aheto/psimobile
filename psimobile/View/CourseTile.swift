//
// Created by Makafui Aheto on 13/02/2023.
//

import Foundation

import SwiftUI

struct CourseTile: View {

    var imageView: UIImageView!

    @State var istoggled: Bool

    var courses: [CourseDTO]

    init(istoggled: Bool, courses: [CourseDTO]) {
        self.istoggled = istoggled
        self.courses = courses
    }

    var body: some View{



                ScrollView(.horizontal, showsIndicators: false) {

                    VStack{

                        HStack(spacing: 15) {

                            ForEach(courses) { course in

                                let thumbNailUrl = course.thumbNailPath

                                 let image = imageView.loadFrom(URLAddress: thumbNailUrl)

                                Button(action: { withAnimation{
                                    istoggled = true

                                } }, label: {

                                        Image(uiImage: image)
                                            .resizable()
                                            .renderingMode(.original)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 170, height: 100)
                                                .padding(.init(top: 0, leading: 10, bottom: 20, trailing: 10))

                                    })


                            }

                        }

                    }


                }


        }



    }


extension UIImageView{

    func loadFrom(URLAddress: String)->UIImage{

        guard let imageUrl = URL(string: URLAddress) else {return self.image!}

        DispatchQueue.main.async{ [weak self] in

            if let imageData = try? Data(contentsOf: imageUrl){
                if let loadedImage = UIImage(data: imageData){
                    self? .image = loadedImage
                }
            }

        }

        return self.image!
    }

}
