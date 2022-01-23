//
//  Service .swift
//  Psi
//
//  Created by Makafui Aheto on 16/09/2021.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

struct SessionUserDetails{
    let firstName: String
    let lastname: String
}


enum SessionState{
    case loggedIn
    case loggedOut
}


protocol SessionService{
    
    var state: SessionState{get}
    var userDetails: SessionUserDetails? {get}
    func logout()
}

final class SessionServiceImpl: ObservableObject, SessionService {
    
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: SessionUserDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
    func setupFirebaseAuthHandler(){
        
        handler = Auth
            .auth()
            .addStateDidChangeListener{[weak self] res, user in
                guard let self = self else {return}
                self.state = user == nil ? .loggedOut : .loggedIn
            }
        
    }
    
    func handleRefresh(with uid: String){
        
        Database
            .database()
            .reference()
            .child("users")
            .observe(.value){[weak self] snapshot in
                guard let self = self,
                let value = snapshot.value as? NSDictionary,
                let firstName = value[RegistrationKeys.firstName.rawValue] as? String,
                let lastName = value[RegistrationKeys.lastName.rawValue] as? String else{return}
                
                DispatchQueue.main.async{
                    self.userDetails = SessionUserDetails(firstName: firstName, lastname: lastName)
            }
        
       
        }
    }
    
 
    
    
}
