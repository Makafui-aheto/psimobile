//
//  SignInForm.swift
//  Psi
//
//  Created by Makafui Aheto on 09/09/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Combine

struct SignInForm: View {
    
    @State private var email: String = " "
    @State private var password: String = ""
    @State private var showView: Bool = false
    @State private var isSignedin: Bool = false
    
    @EnvironmentObject var authentication: UserAuthentication
    
    var body: some View {
        NavigationView{
           
           ScrollView{
               
               VStack(alignment:.leading){
                   
                   Text("Email :")
                    .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
                   
                       TextField("UserName", text: $email)
                           .disableAutocorrection(true)
                           .autocapitalization(.none)
                           .padding()
                           .frame(width:300, height:30)
                           .background(lightGray)
                           .cornerRadius(5.0)
                           .padding(.bottom)
                           .font(.body)
                           .foregroundColor(.black)
                       
                   
                   
                   Text("Password :").multilineTextAlignment(.leading)
                   
                       SecureField("Password", text: $password)
                           .disableAutocorrection(true)
                           .autocapitalization(.none)
                           .padding()
                           .background(lightGray)
                           .frame(width:300, height: 30)
                           .cornerRadius(5.0)
                           .padding(.bottom)
                           .foregroundColor(.black)
               }
               .padding(.init(top: 40, leading: 50, bottom: 50, trailing: 50))
               
               
               Button(action: {
                   authentication.login(email: email, password: password)
                   
               }, label: {
                  Text("Sign In")
               })
               .frame(width:200, height:40, alignment: .center)
               .background(Color.blue)
               .cornerRadius(10)
               .padding(90)
           .foregroundColor(Color(.white))
               
               NavigationLink(destination:Home_Screen(), isActive: $isSignedin) {
                                EmptyView()
                               }
               
           }
           
          
               
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
              
    }
    
    func login(email: String, password: String){
            
            Auth.auth().signIn(withEmail: email, password: password){ [self] result, error in
                
                if (error != nil){
                    authentication.displayAlert(withTitle: "Error", message: error!.localizedDescription)
                    print(error!.localizedDescription)
                }
                
                DispatchQueue.main.async{
                    isSignedin = true
                }
                
            }
            
        }
}

struct SignInForm_Previews: PreviewProvider {
    static var previews: some View {
        SignInForm().environmentObject(UserAuthentication())
    }
}
