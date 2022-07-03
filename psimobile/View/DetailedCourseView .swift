//
//  DetailedCourseView .swift
//  Psi
//
//  Created by Makafui Aheto on 06/09/2021.
//

import SwiftUI

struct DetailedCourseView_: View {

    @EnvironmentObject var courseData: CourseDetailModel
    var animation: Namespace.ID
    @State private var istoggled = false
    //@State private var textColor = (Color(.systemBackground)==Color(.white)) ? Color(.black) : Color(.white)
    @Environment(\.colorScheme) var colorScheme


    var body: some View {

        let author = "By:\t" + courseData.selectedCourse.courseAuthor

        if (courseData.selectedCourse != nil){

            ZStack{

                Rectangle()
                        .opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture{
                            withAnimation{
                                courseData.showCourseDetails.toggle()
                            }

                        }

                //Rectangle()
                // .foregroundColor(.white)
                // .frame(width:350, height:500)
                //.cornerRadius(10)

                VStack{

                    VStack(alignment:.leading){

                        Image(courseData.selectedCourse.courseProfilePic)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fill)
                                .frame(width:320, height:135)
                                .matchedGeometryEffect(id: courseData.selectedCourse.id, in: animation)
                                .background(
                                        Color(.black)
                                                .opacity(0.1)
                                                .onTapGesture {
                                                    withAnimation {
                                                        courseData.selectedCourse=nil
                                                        courseData.showCourseDetails.toggle()

                                                    }
                                                }


                                )
                                .padding(.init(top: 0, leading: 10, bottom: 20, trailing: 10))
                                .cornerRadius(5)
                                .overlay(

                                        Image(systemName:"play")
                                                .foregroundColor(.white)

                                )

                        Text("COURSE")
                                .font(.none)
                                .foregroundColor(.gray)
                                .padding(.init(top: 0, leading: 30, bottom: 5, trailing: 10))

                        Text(courseData.selectedCourse.courseTitle)
                                .font(.title)
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .padding(.init(top: 0, leading: 30, bottom: 5, trailing: 10))

                        Text(author)
                                .font(.system(size: 16, weight: .light, design: .default))
                                .foregroundColor(.gray)
                                .padding(.init(top: 0, leading: 30, bottom: 5, trailing: 10))

                        Text(courseData.selectedCourse.courseDescription)
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
                            courseData.showCourseDetails.toggle()
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

struct DetailedCourseView__Previews: PreviewProvider {
    static var previews: some View {
        Home_Screen()
    }
}
