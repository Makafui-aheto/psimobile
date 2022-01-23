//
//  ContentView.swift
//  psimobile
//
//  Created by Makafui Aheto on 24/09/2021.
//

import SwiftUI
import CoreData

struct SubjectOverlay: View{
    
    @State var showCompanyLogo = true
    @State var propels = true
    
    
    var body: some View{
        VStack(alignment:.center){
            if showCompanyLogo {
                
                HStack{
                    Image(systemName: "globe")
                        .foregroundColor(.white)
                        .font(Font.title.weight(.bold))
                    Text("Psi Learning")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding(6)
                        .foregroundColor(.white)
                }
                .opacity(propels ? 1:0)
                .position(y: showCompanyLogo ? 100 : 0)
                .offset(x:UIScreen.main.bounds.size.width/2, y:propels ? 50 : -300)
                
                .animation(Animation.easeInOut(duration:3).delay(3).repeatCount(0, autoreverses: false))
                
                Text("Development of learning. \n Training for you.")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .opacity(propels ? 0:1)
                    .position(y: showCompanyLogo ? 100 : 0)
                    .offset(x:UIScreen.main.bounds.size.width/2, y:propels ? -250 :-400)
                  
                    .animation(Animation.easeInOut(duration:3).delay(3).repeatCount(0, autoreverses: false))
                
                }
            }
            .onAppear(){
                self.propels.toggle()
            }
            Spacer()
        
            
        }
    
            
    }




struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State var offset: CGFloat = 0
    @State private var showLoginView = false

    var body: some View {
        
        let imageArray: [String] = ["background", "studying", "students"]
        
    
        GeometryReader{ geom in
            
            let rect = geom.frame(in: .global)
            
            NavigationView{
                
                ScrollableTab(tabs:tabs, rect:geom.frame(in: .global), offset:$offset){
                                    
                                HStack(spacing: 0){
                                    
                                    ForEach(imageArray, id: \.self){ image in
                                        Image(image)
                                            .resizable()
                                            .renderingMode(.original)
                                            .ignoresSafeArea()
                                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                            .frame(width: rect.width)
                                            .opacity(0.8)
                                            .accentColor(.black)
                                            .cornerRadius(0)
                                            .edgesIgnoringSafeArea(.all)
                                            .overlay(Rectangle().foregroundColor(.black).opacity(0.25).edgesIgnoringSafeArea(.all).ignoresSafeArea(.all))
                                            .overlay(SubjectOverlay(), alignment: .center)
                                    }
                                    .ignoresSafeArea(.all)

                                    }
                                .ignoresSafeArea(.all)
                            }
                            .edgesIgnoringSafeArea(.all)
                            .ignoresSafeArea(.all)
                            .overlay(
                                VStack{
                                    NavigationLink(destination: LoginForm() ){
                                        Text("Sign Up")
                                    }
                                    .frame(width:UIScreen.main.bounds.width * 0.9, height:35)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .padding()
                                    .foregroundColor(.black)
                    
                                
                                    NavigationLink(destination: SignInForm()){
                                        Text("Sign In")
                                    }
                                    .padding(.bottom)
                                    .foregroundColor(.white)
                                    
                                    
                                
                                }
                                
                                , alignment: .bottom)
            
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
                
            }
            
            
         
            }
            .ignoresSafeArea(.all)
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        
       
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .padding(-2)
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            
    }
}



    


var tabs = ["background", "studying", "students"]
