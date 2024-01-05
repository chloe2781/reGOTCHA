//
//  TopView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/8/23.
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct TitleView: View {
    
    @State private var userInput: String = ""
    @State private var userPass: String = ""
    @State private var titleText: String = "Sign Up"
    @ObservedObject var countManager: CountManager
    
    var body: some View {
        VStack {
            Text(titleText)
              .font(Font.custom("Inter", size: 34))
              .foregroundColor(.black)
              .padding(20)            
            
            Text("Username")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .padding(.leading, -140)
            
            TextInputView(userInput: $countManager.username)
                .onChange(of: countManager.username) {
                    let userNametoEmail = countManager.username + "@gmail.com"
                    checkIfEmailIsRegistered(userEmail: userNametoEmail) { isRegistered in
                            if isRegistered {
                                // Handle the case where the email is registered
                                // For example, show an alert or update the UI
                                print("Email is already registered")
                                
                                countManager.loseMessage = "Username is taken, you're not unique"
                                countManager.answer = false
                            } else {
                                // Handle the case where the email is not registered
                                // For example, enable the next step in the sign-up process
                                print("Email is not registered")
                            }
                        }

                }
            
            Text("Password")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .padding(.leading, -140)
            
            SecureTextInputView(userInput: $countManager.password)
                .onChange(of: countManager.password) {
                    let newValue = countManager.password
                    
                    let uppercaseSet = CharacterSet.uppercaseLetters
                    let digitSet = CharacterSet.decimalDigits

                    let containsUppercase = newValue.unicodeScalars.contains { char in
                        uppercaseSet.contains(char)
                    }

                    let containsDigit = newValue.unicodeScalars.contains { char in
                        digitSet.contains(char)
                    }
                    
                    print(newValue.count)
                    print(containsUppercase)
                    print(containsDigit)
                    print("\n")
                    
                    if newValue.count >= 6 && containsUppercase && containsDigit {
//                        countManager.password = newValue
                        countManager.answer = true
                    } else {
                        countManager.answer = false
                        countManager.loseMessage = "What kind of human can't follow directions? ROBOT!"
                    }
                    
                }
            
            Text("(6 characters, 1 number, 1 capital letter)")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .padding(.leading, -15)
                .padding(.top, -20)
            
        }.onAppear{
            if countManager.isLogin {
                titleText = "Log In"
            }
        }
    }
            
            /*
            
            Button(action: {
                // Increment the count when the button is clicked
                register()

                
            }) {
                Text("SIGN UP")
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
            
            //Text("If you already have an account")
            //    .font(Font.custom("Inter", size: 15))
            //    .foregroundColor(.black)
            //    .padding(20)
             */
            

//    func register(){
//        
//        let userNametoEmail = countManager.username + "@gmail.com"
//        
//        Auth.auth().createUser(withEmail: userNametoEmail, password: countManager.password){ result, error in
//            if let error = error {
//                print("Error registering user: \(error.localizedDescription)")
//            } else {
//                print("User registered successfully")
//            }    
//        
//        }
//    }
    
    private func checkIfEmailIsRegistered(userEmail: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")

        usersCollection.whereField("email", isEqualTo: userEmail).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error querying Firestore: \(error.localizedDescription)")
                completion(false)  // Assume not registered in case of error
            } else {
                let isRegistered = !snapshot!.documents.isEmpty
                completion(isRegistered)
                countManager.answer = false
                countManager.loseMessage = "You're not that unique, choose another name."
            }
        }
    }

}

#Preview {
    TitleView(countManager: CountManager())
}
