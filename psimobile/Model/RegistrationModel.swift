//
//  RegistrationModel.swift
//  Psi
//
//  Created by Makafui Aheto on 16/09/2021.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseDatabase

enum RegistrationKeys: String{
    case firstName
    case lastName
}

protocol Registration{
    func register(with details: StudentProfile) -> AnyPublisher<Void, Error>
}

final class RegistrationSuccess: Registration{
  
    func register(with details: StudentProfile) -> AnyPublisher<Void, Error>{
        Deferred{
            Future{ promise in
                Auth.auth()
                    .createUser(withEmail: details.email, password: details.password){res, error in
                        
                       
                        if let err = error{
                            let x = err as NSError
                            
                            promise(.failure(err))
                            
                             switch x.code {
                             
                             case AuthErrorCode.wrongPassword.rawValue:
                                print("wrong password")
                             case AuthErrorCode.invalidEmail.rawValue:
                                print("invalid email")
                             case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                                print("Account Exists With Different Credential")
                             case AuthErrorCode.emailAlreadyInUse.rawValue: //<- Your Error
                                print("email is alreay in use")
                             default:
                                print("unknown error: \(err.localizedDescription)")
                             }
                            
                            
                        }else{
                            if let uid = res?.user.uid{
                                
                                let values = [
                                    RegistrationKeys.firstName.rawValue: details.firstName,
                                    RegistrationKeys.lastName.rawValue: details.lastName
                                ] as [String:Any]
                                
                                Database.database()
                                        .reference()
                                        .child("users")
                                        .child(uid)
                                        .setValue(values){error, ref in
                                            if let err = error{
                                                promise(.failure(err))
                                            }else{
                                                promise(.success(()))
                                            }
                                    }
                                
                            }else{
                                promise(.failure(NSError(domain: "Invalid User Id", code:0, userInfo:nil)))
                            }
                        }
                        
                    }
                
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
