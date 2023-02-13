//
// Created by Makafui Aheto on 13/02/2023.
//

import Foundation

import SwiftUI

struct CourseTile: View {

    @EnvironmentObject var courseModel: CourseModel

    var imageView: UIImageView!

    @Binding var courses: [CourseDTO]

    var animation: Namespace.ID

    var body: some View{

        VStack{

            VStack(alignment:.leading){

                ForEach($courses){  course in

                   imageView.loadFrom(URLAddress: course.videoUrl)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width:50, height:100)
                            .matchedGeometryEffect(id: UUID().uuidString, in: animation)
                }

            }
                    .frame(width:50, height:180)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    .padding(15)

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
