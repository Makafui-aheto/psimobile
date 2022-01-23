//
//  RegistrationViewModel .swift
//  Psi
//
//  Created by Makafui Aheto on 16/09/2021.
//

import Foundation
import FirebaseAuth
import Combine


enum RegistrationState {
    
    case successful
    case failed(error: Error)
    case na
}

protocol RegistrationView {
    
    
    
    func register()
    var service: Registration{get}
    var state: RegistrationState{get}
    var userDetails: StudentProfile{get}
    init(service: Registration)
    
}

final class RegistrationViewModel: ObservableObject, RegistrationView{
    
    let service: Registration
    var state: RegistrationState = .na
    var userDetails: StudentProfile = StudentProfile(email: "", password: "", firstName: " ", lastName: " ")
  
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: Registration) {
        self.service = service
    }
    
    
    func register() {
        service
            .register(with: userDetails)
            .sink{ [weak self] res in
                
                    switch res{
                        
                    case .failure(let error):
                        self?.state = .failed(error: error)
                        
                    default: break
                        
                    }
                
            }receiveValue: { [weak self] in
                self?.state  = .successful
            }
            .store(in: &subscriptions)
        
    }
    
}
