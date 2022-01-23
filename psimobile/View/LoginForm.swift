//
//  LoginForm.swift
//  Psi
//
//  Created by Makafui Aheto on 29/08/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Combine



enum Details: String{
    case Userid
    case firstName
    case lastName
}

let db = Firestore.firestore()

let lightGray = Color(red:239.0/255.0, green:243.0/255.0, blue:244.0/255.0)

class User{
    
    var uid: String
    var email: String?
    
    init(uid:String, email:String?){
        self.uid = uid
        self.email = email
    }
}


class UserAuthentication: ObservableObject{
    
    var statusChange = PassthroughSubject<UserAuthentication, Never>()
    var session: User? { didSet{ self.statusChange.send(self) } }
    var handler: AuthStateDidChangeListenerHandle?
    var isloggedin = false
    var isSignedin = false
    
    var error = ""
    var userid = ""
    var alert = false
    
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        let viewController = UIApplication.shared.windows.first!.rootViewController!
           viewController.present(alert, animated: true, completion: nil)
       }
    
    func login(email: String, password: String){
            
            Auth.auth().signIn(withEmail: email, password: password){ [weak self] result, error in
                
                if (error != nil){
                    self?.displayAlert(withTitle: "Error", message: error!.localizedDescription)
                    print(error!.localizedDescription)
                }
                
                DispatchQueue.main.async{
                    self?.isSignedin = true
                }
                
            }
            
        }
    
    func listener(){
        
        handler = Auth.auth().addStateDidChangeListener{(auth, user) in
            if let user = user{
                self.session = User(uid: user.uid, email: user.email)
                
            }else{
                self.session = nil
            }
        }
        
        
    }
    
}


struct LoginForm: View {
    
    @State var showView = false
    @State var buttonIsToggled = false
    @EnvironmentObject var authModel: UserAuthentication
    @State var userauthentication = UserViewModel()

    
    var body: some View {
      
        
        
 NavigationView{
    
    ScrollView{
        
        VStack(alignment:.leading){
            
            Group {
                VStack(alignment:.leading){
                    Text("First name")
                    
                    TextField("FirstName", text: $userauthentication.firstname)
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding()
                            .frame(width:300, height:30)
                            .background(lightGray)
                            .cornerRadius(5.0)
                            .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .foregroundColor(.black)
                    
                    if !userauthentication.validfirstNameText.isEmpty && self.buttonIsToggled == true{
                                                Text(userauthentication.validfirstNameText).font(.caption).foregroundColor(.red)
                            .padding(.bottom)
                                            }
                }
                
                VStack(alignment:.leading){
                    Text("Last name")
                    
                    TextField("LastName", text: $userauthentication.lastname)
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding()
                            .frame(width:300, height:30)
                            .background(lightGray)
                            .cornerRadius(5.0)
                            .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .foregroundColor(.black)
                    
                    if !userauthentication.validlastNameText.isEmpty && self.buttonIsToggled == true{
                                                Text(userauthentication.validlastNameText).font(.caption).foregroundColor(.red)
                            .padding(.bottom)
                                            }
                }
                
                
                VStack(alignment:.leading){
                    Text("Email")
                    
                    TextField("Email", text: $userauthentication.email)
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding()
                            .frame(width:300, height:30)
                            .background(lightGray)
                            .cornerRadius(5.0)
                            .font(.body)
                            .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .foregroundColor(.black)
                            //.overlay(
                                //ZStack(alignment:.leading){
                                    //Image(systemName: "envelope")
                                        //.offset(x:-130)
                                //}
                            //)
                    
                    if !userauthentication.validEmailAddressText.isEmpty && self.buttonIsToggled == true{
                                               Text(userauthentication.validEmailAddressText).font(.caption).foregroundColor(.red)
                            .padding(.bottom)
                                           }
                }
                
                VStack(alignment:.leading){
                  
                    Text("Password").multilineTextAlignment(.leading)
                    
                    SecureField("Password",text: $userauthentication.password)
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .padding()
                            .background(lightGray)
                            .frame(width:300, height: 30)
                            .cornerRadius(5.0)
                            .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .foregroundColor(.black)
                    
                    if !userauthentication.validPasswordText.isEmpty && self.buttonIsToggled == true{
                                                Text(userauthentication.validPasswordText).font(.caption).foregroundColor(.red)
                                            }
                }
                
                
            }
            


            
            
       
        }
        .padding(.init(top: 40, leading: 50, bottom: 50, trailing: 50))
        
    
        Button(action: {
            
            self.buttonIsToggled = true
            
            createNewUser(firstName: self.userauthentication.firstname, lastName: self.userauthentication.lastname, email: self.userauthentication.email, password: self.userauthentication.password)
            
        }, label: {
            Text("Create Account")
        })
        .frame(width:200, height:40, alignment: .center)
        .background(Color.blue)
        .cornerRadius(10)
        .padding(90)
    .foregroundColor(Color(.white))
        
        NavigationLink(destination:Home_Screen(), isActive:$showView) {
                         EmptyView()
                        }
        
        
    }
    .background(Color(.systemBackground))
    
   
        
 }
 .navigationBarHidden(true)
 .navigationBarBackButtonHidden(true)
 .navigationViewStyle(StackNavigationViewStyle())
       
    }
    
    func createNewUser(firstName: String, lastName:String, email:String, password:String){
            
            Auth.auth().createUser(withEmail: email, password: password){ [self] result, error in
                
                if (error != nil){
                    
                    authModel.displayAlert(withTitle: "Error", message: error!.localizedDescription)
                    
                    return
                }else{
                    
                    let userDetails = [
                        Details.Userid.rawValue: result?.user.uid,
                        Details.firstName.rawValue: firstName,
                        Details.lastName.rawValue: lastName
                    ]
                    
                    
                    self.showView = true
                    
                    DispatchQueue.main.async{
                        self.showView = true
                    }
                    
                    
                    db.collection("users")
                        .document((result?.user.uid)!)
                        .setData(userDetails as [String : Any])
                    
                }
            
            
        }
    
    }
    
    
}


struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
            .environmentObject(UserAuthentication())
    }
}
