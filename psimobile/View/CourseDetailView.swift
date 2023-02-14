//
// Created by Makafui Aheto on 14/02/2023.
//

import Foundation
import AVFoundation
import SwiftUI
import AVKit

struct CourseDetailView: View {

    var courseData: courseDTO
    var animation: Namespace.ID
    @State private var istoggled = false
    var xmarktoggled = false
    var introductoryVideoUrl: String
    @Environment(\.colorScheme) var colorScheme


    var body: some View {

        let author = "By:\t" + courseData.author

        let video = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: introductoryVideoUrl, ofType: "mp4")))



            ZStack{

                Rectangle()
                        .opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture{
                            withAnimation{
                                istoggled.toggle()
                            }


                VStack{

                    VStack(alignment:.leading){

                        VideoPlayer(player: video)
                                .frame(width: 320, height: 135)
                                .aspectRatio(contentMode: .fill)
                                .symbolRenderingMode(.multicolor)
                                .matchedGeometryEffect(id: UUID().uuidString, in: amination)
                                .padding(.init(top: 0, leading: 10, bottom: 20, trailing: 10))
                                .cornerRadius(5)

                        Text("COURSE")
                                .font(.none)
                                .foregroundColor(.gray)
                                .padding(.init(top: 0, leading: 30, bottom: 5, trailing: 10))

                        Text(courseData.videoTitle)
                                .font(.title)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .padding(.init(top: 0, leading: 30, bottom: 5, trailing: 10))

                        Text(author)
                                .font(.system(size: 16, weight: .light, design: .default))
                                .foregroundColor(.gray)
                                .padding(.init(top: 0, leading: 30, bottom: 5, trailing: 10))

                        Text(courseData.videoDescription)
                                .foregroundColor(.gray)
                                .padding(.init(top: 0, leading: 30, bottom: 20, trailing: 10))

                        Spacer()


                        HStack{
                            Text("Skills : Actuarial Science")
                                    .foregroundColor(.gray)
                            Spacer()

                            Button(action: {istoggled = !istoggled}, label: {
                                Image(systemName: (istoggled==false) ? "bookmark" : "bookmark.fill")
                                        .foregroundColor(.blue)
                                Text("Save")
                                        .foregroundColor(.blue)
                            })

                        }
                                .padding(.init(top: 0, leading: 30, bottom: 20, trailing: 10))


                    }
                            .frame(width:320, height:450)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(10)

                    Button(action:{
                        withAnimation{
                            xmarktoggled.toggle()
                        }

                    }){
                        Image(systemName: "xmark")
                                .resizable()
                                .frame(width:12, height:12)
                                .foregroundColor(.black)
                                .padding(20)
                    }
                            .background(Color.white)
                            .clipShape(Circle())
                            .padding(.top, 10)
                }


            }

    }



}
}

