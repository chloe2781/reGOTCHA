//
//  RecaptchaViewModel.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 12/1/23.
//

//import Foundation
//import RecaptchaEnterprise
//
//@MainActor class RecaptchaViewModel: ObservableObject {
//    private var recaptchaClient: RecaptchaClient?
//            
//    init() {
//        Task {
//            do {
//                let client = try await Recaptcha.getClient(withSiteKey: "6LecQCMpAAAAAHZ0Y6Chw8pUh-KeOSJbE92xCBPY")
//                self.recaptchaClient = client
//            } catch let error as RecaptchaError {
//                print("RecaptchaClient creation error: \(String(describing: error.errorMessage)).")
//            }
//        }
//    }
//    
//    func execute() {
//        guard let recaptchaClient = self.recaptchaClient else {
//            print("Client not initialized correctly.")
//            return
//        }
//
//        Task {
//            do {
//                let token = try await recaptchaClient.execute(withAction: RecaptchaAction.login)
//                print(token)
//            } catch let error as RecaptchaError {
//                print(error.errorMessage)
//            }
//            
//        }
//    }
//
//}
