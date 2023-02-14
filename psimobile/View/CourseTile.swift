//
// Created by Makafui Aheto on 13/02/2023.
//

import Foundation

import SwiftUI

struct CourseTile: View {

    @EnvironmentObject var courseModel: CourseModel

    var imageView: UIImageView!

    @State var isHovered: Bool = false

    @Binding var courses: [CourseDTO]

    var animation: Namespace.ID

    var body: some View{

        VStack{

            VStack(alignment:.leading){

                ForEach($courses){  course in

                    imageView.loadFrom(URLAddress: course.thumbNailPath)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: isHovered ? 320 : 50, height:150)
                            .matchedGeometryEffect(id: UUID().uuidString, in: animation)
                            .padding(.init(top: 0, leading: 10, bottom: 20, trailing: 10))

                    if isHovered{

                    }


                }

            }
                    .frame(width: isHovered ? 320:50, height: isHovered ? 450:250)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    .padding(15)
                    .onHover { isHovered in
                        withAnimation {
                            self.isHovered = true
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
