//
//  HomeTab.swift
//  Psi
//
//  Created by Makafui Aheto on 06/09/2021.
//

import SwiftUI
import AVFoundation

struct Home: View{
    
    @State private var searchCourse: String = "Search For Courses"
    @EnvironmentObject var courseData: CourseDetailModel
    
    var animation: Namespace.ID
    
    var body: some View{
    

    ScrollView{
        
        VStack(alignment:.leading){
        
        ZStack{
            
            Color(.white)
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack(alignment:.top){
                    
                    ForEach(initializers){
                        
                        recent in
                        
                        Button(action:{
                            
                            withAnimation{
                                courseData.selectedCourse = recent
                                courseData.showCourseDetails.toggle()
                            }
                            
                        }, label:{
                            
                            ZStack{
                                
                                if courseData.showCourseDetails{
                                    Image(recent.courseProfilePic)
                                        .resizable()
                                        .renderingMode(.original)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width:UIScreen.main.bounds.width*0.75, height:180)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .overlay(Rectangle()
                                                    .foregroundColor(Color(UIColor.systemBackground))
                                                    .cornerRadius(10))
                                        .padding(15)
                                    
                                    
                                    Blur(style: .light)
                                        .frame(width:UIScreen.main.bounds.width*0.75, height:180)
                                        .cornerRadius(10)
                                        .padding(15)
                                        .foregroundColor(Color(UIColor.systemBackground))
                                    
                                    Image(recent.courseProfilePic)
                                        .resizable()
                                        .renderingMode(.original)
                                        .aspectRatio(contentMode: .fill)
                                        //.matchedGeometryEffect(id: recent.id, in: animation)
                                        .frame(width:UIScreen.main.bounds.width*0.75, height:180)
                                        .mask(
                                            
                                            LinearGradient(gradient: Gradient(stops:[.init(color:Color(UIColor.systemBackground), location:0), .init(color:Color(UIColor.systemBackground), location:0), .init(color: Color(UIColor.systemBackground).opacity(0), location: 0.6)]), startPoint: .bottomTrailing, endPoint: .bottomLeading)
    
                                        
                                        )
                                        .cornerRadius(10)
                                        .overlay(
                                            
                                            VStack(alignment:.leading, spacing:10){
                                                
                                                Text("New")
                                                    .frame(width: 40, height:20)
                                                    .background(Color(UIColor.systemBackground))
                                                
                                                    .cornerRadius(5)
                                                    .shadow(radius: 20)
                                            
                                            
                                                Text(recent.courseTitle)
                                                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                                    .font(.title2)
                                                    
                                            }
                                            .frame(width:180)
                                            .position(x: 100, y: 90)
                                                    )
                                        
                                    
                                }else{
                                    Image(recent.courseProfilePic)
                                        .resizable()
                                        .renderingMode(.original)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width:UIScreen.main.bounds.width*0.75, height:180)
                                        .background(Color(UIColor.systemBackground))
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .overlay(Rectangle()
                                                    .foregroundColor(Color(UIColor.systemBackground))
                                                    .cornerRadius(10))
                                        .padding(15)
                                    
                                    
                                    Blur(style: .light)
                                        .frame(width:UIScreen.main.bounds.width*0.75, height:180)
                                        .cornerRadius(10)
                                        .padding(15)
                                        .foregroundColor(Color(UIColor.systemBackground))
                                    
                                    Image(recent.courseProfilePic)
                                        .resizable()
                                        .renderingMode(.original)
                                        .aspectRatio(contentMode: .fill)
                                        .background(Color(UIColor.systemBackground))
                                        .matchedGeometryEffect(id: recent.id, in: animation)
                                        .frame(width:UIScreen.main.bounds.width*0.75, height:180)
                                        .mask(
                                            
                                            LinearGradient(gradient: Gradient(stops:[.init(color:Color(UIColor.systemBackground), location:0), .init(color:Color(UIColor.systemBackground), location:0), .init(color: Color(UIColor.systemBackground).opacity(0), location: 0.6)]), startPoint: .bottomTrailing, endPoint: .bottomLeading)
    
                                        
                                        )
                                        .cornerRadius(10)
                                        .overlay(
                                            
                                            VStack(alignment:.leading, spacing:10){
                                                
                                                Text("New")
                                                    .frame(width: 40, height:20)
                                                    .background(Color(UIColor.systemBackground))
                                                
                                                    .cornerRadius(5)
                                                    .shadow(radius: 20)
                                            
                                            
                                                Text(recent.courseTitle)
                                                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                                    .font(.title2)
                                                    
                                            }
                                            .frame(width:180)
                                            .position(x: 100, y: 90)
                                                    )
                                        
                                }
                            
                            }
                            
                        })
                    
                        .buttonStyle(PlainButtonStyle())
                        
                        
                        
                    }
                    .background(Color(UIColor.systemBackground))
                    
                }
                .background(Color(UIColor.systemBackground))
                
            }
            .background(Color(UIColor.systemBackground))
            
        }
        .padding(20)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .ignoresSafeArea(.all)
        .background(Color(UIColor.systemBackground))
        
            
       Text("Top Course Picks")
        .font(.title2)
        .multilineTextAlignment(.leading)
        .padding(.init(top: 0, leading: 35, bottom: 10, trailing: 0))
            
            
        
    }
        
    }
    .overlay(
        ZStack(alignment: .top, content: {
            if courseData.showCourseDetails{
                DetailedCourseView_(animation: animation)
            }
        })
        
    )
            
    }
        
}
    

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        Home_Screen()
    }
}
