//
// Created by Makafui Aheto on 13/02/2023.
//

import Foundation

import SwiftUI

struct CourseTile: View {

    var courseModel: CourseModel

    var imageView: UIImageView!

    var istoggled: Bool

    @Binding var courses: [CourseDTO]

    var animation: Namespace.ID


    private func getScale(proxy: GeometryProxy) -> CGFloat{
        var scale: CGFloat = 1

        let x = proxy.frame(in: .global).minX

        let diff = abs(x-32)

        if diff < 100{
            scale = 1 + (100-diff)/500
        }

        return scale
    }

    var body: some View{



                ScrollView(.horizontal, showsIndicators: false) {

                    VStack{

                        HStack(spacing: 15) {

                            ForEach($courses) { course in

                                Button(action: { withAnimation{istoggled = true} }, label: {

                                    imageView.loadFrom(URLAddress: course.thumbNailPath)
                                            .resizable()
                                            .renderingMode(.original)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 170, height: 100)
                                            .matchedGeometryEffect(id: UUID().uuidString, in: animation)

                                    })


                            }

                        }

                    }


                }


        }



    }


extension UIImageView{

    func loadFrom(URLAddress: String){

        guard let imageUrl = URL(string: URLAddress) else {return }

        DispatchQueue.main.async{ [weak self] in

            if let imageData = try? Data(contentsOf: imageUrl){
                if let loadedImage = UIImage(data: imageData){
                    self? .image = loadedImage
                }
            }

        }
    }

}
