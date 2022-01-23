//
//  Home_Screen.swift
//  Psi
//
//  Created by Makafui Aheto on 03/09/2021.
//

import SwiftUI


struct Notifications: View{

    var body: some View{
        
        NavigationView{
            
            ZStack{
                
            }
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
}


struct ErrorView: View{
    
    @Binding var errorMessage: String
    
    var body: some View{
        
        VStack{
            
                            
        }
        
    }
    
}




struct Home_Screen: View {
    
    @State private var searchCourse: String = "Search For Courses"
    @State private var pageLoading: Bool = false
    @Namespace var animation
    @StateObject var  courseData = CourseDetailModel()
    @StateObject private var vm = RegistrationViewModel(service: RegistrationSuccess())
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some View {
        
        
        ZStack {
            
            TabView{
                        NavSearchView(view: AnyView(Home(animation: animation)),
                                      onSearch:{(txt) in print("Swift UI")}, onCancel: {print("Cancel Swift")})
                            .environmentObject(courseData)
                            .ignoresSafeArea(.all)
                            .navigationBarHidden(true)
                            .tabItem{
                               Image(systemName: "house")
                                .foregroundColor(.black)
                                .accentColor(.black)
                                .padding(5)
                                
                                Text("Home")
                                
                            }
                            
                        NavSearchView(view: AnyView(Courses()),
                              onSearch:{(txt) in print("Swift UI")}, onCancel: {print("Cancel Swift")})
                         .ignoresSafeArea(.all)
                         .navigationBarHidden(true)
                         .tabItem{
                            Image(systemName: "text.book.closed")
                             .foregroundColor(.black)
                             .accentColor(.black)
                             .padding(5)
                             
                             Text("Courses")
                             
                         }
                         .accentColor(.white)
                
                           Settings()
                            .tabItem{
                               Image(systemName: "gear")
                                .foregroundColor(.black)
                                .accentColor(.black)
                                .padding(5)
                                
                                Text("Settings")
                                
                            }
                            .accentColor(.white)
                
                         
                        
                            Notifications()
                             .tabItem{
                                Image(systemName: "bell")
                                 .foregroundColor(.black)
                                 .accentColor(.black)
                                 .padding(5)
                                 
                                 Text("Notifications")
                                 
                             }
                             .accentColor(.white)
                    }.onAppear(){
                        loadingPage()
                }
            
            if pageLoading{
                
                ZStack{
                    Color(.systemBackground)
                        .ignoresSafeArea(.all)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint:.gray))
                        .scaleEffect(1.5)
                }
                
            }
        }
        
        
        
        }
    
    func loadingPage(){
        
        pageLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            pageLoading = false
        }
        
    }
         
}

struct changeinState: View{
    
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some View {
        
        NavigationView{
            
            switch sessionService.state{
            case .loggedIn:
                Home_Screen()
            case .loggedOut:
                SignInForm()
            
            
            }
            
            
            
        }
        
        
    }
    
    
}




struct Home_Screen_Previews: PreviewProvider {
    static var previews: some View {
        changeinState()
    }
}
