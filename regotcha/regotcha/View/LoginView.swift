//
//  loginView.swift
//  regotcha
//
//  Created by Gulshan Meem on 12/2/23.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth

struct LoginView: View {
    
    @State private var userInput: String = ""
    @ObservedObject var countManager: CountManager
    @State private var showAlert = false
    @State private var loginSuccess = false
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView{
            
            VStack {
                Text("Log In")
                    .font(Font.custom("Inter", size: 34))
                    .foregroundColor(.black)
                    .padding(20)
                
                Text("Username")
                    .font(Font.custom("Inter", size: 15))
                    .foregroundColor(.black)
                    .padding(.leading, -140)
                
                TextInputView(userInput: $countManager.username)
                
                
                Text("Password")
                    .font(Font.custom("Inter", size: 15))
                    .foregroundColor(.black)
                    .padding(.leading, -140)
                
                SecureTextInputView(userInput: $countManager.password)
                    .onChange(of: userInput) {
                        countManager.password = userInput
                    }
                NavigationLink(
                    destination: ContentView(countManager: countManager).navigationBarBackButtonHidden(),
                    isActive: $isActive
                ) {
                    EmptyView()
                }
                .hidden()
                Button(action: {
                    // Increment the count when the button is clicked
                    login()
                    print(countManager.email)
                    print(countManager.username)
                    print(countManager.password)
                    
                }) {
                    Text("LOGIN")
                        .font(
                            Font.custom("Inter", size: 18)
                                .weight(.bold)
                        )
                        .foregroundColor(.white)
                }
                .frame(width: 141, height: 50)
                .background(Color(red: 0.25, green: 0.47, blue: 0.22))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.25, green: 0.47, blue: 0.22), lineWidth: 1)
                )
                .alert(isPresented: $showAlert) {
                    if loginSuccess {
                        return Alert(
                            title: Text("Login Successful"),
                            message: Text("Oh, so you've been here before..."),
                            dismissButton: .default(Text("OK")) {
                                // Navigate to ContentView upon successful login
                                // You need to implement your own navigation logic here
                                isActive = true
                                countManager.isLogin = true
                                countManager.count = 2
                            }
                        )
                        
                    } else {
                        return Alert(
                            title: Text("Login Failed"),
                            message: Text("Please check your username and password and try again."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
        }
    }
        
    func login(){
        
        let userNametoEmail = countManager.username + "@gmail.com"
        
        Auth.auth().signIn(withEmail: userNametoEmail, password: countManager.password){ result, error in
            if let error = error {
                print("Error loging in: \(error.localizedDescription)")
                showAlert = true
                loginSuccess = false
            } else {
                print("User logged in successfully")
                showAlert = true
                loginSuccess = true
            }
        }
    }
}

#Preview {
    LoginView(countManager: CountManager())
}

