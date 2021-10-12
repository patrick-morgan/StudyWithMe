//
//  SignUpView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/22/21.
//

import SwiftUI
import RealmSwift

struct SignUpView: View {
//    @State var email: String = ""
//    @State var password: String = ""
//    @State var confirmPassword: String = ""
//    @State var authFailed: Bool = false
//    @State var firstName: String = ""
//    @State var lastName: String = ""

    var body: some View {
        VStack {
            Text("Create an Account")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .fontWeight(.semibold)
                .padding(.top, -50)
            
            SignUpInfoView()

//            SignUpInfoView(email: $email, password: $password, authFailed: $authFailed)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

struct SignUpInfoView: View {
//    @Binding var email: String
//    @Binding var password: String
//    @Binding var authFailed: Bool
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var authFailed: Bool = false
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var loading: Bool = false
    @EnvironmentObject var state: AppState

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
//            TextField("First name", text: $firstName)
//                .padding()
//                .background(lightGreyColor)
//                .cornerRadius(5.0)
//                .frame(maxWidth: .infinity)
//                .padding(.bottom, 8)
//            TextField("Last name", text: $lastName)
//                .padding()
//                .background(lightGreyColor)
//                .cornerRadius(5.0)
//                .frame(maxWidth: .infinity)
//                .padding(.bottom, 8)
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity)
            if authFailed {
                Text("Login failed. Try again.")
                    .offset(y: -10)
                    .foregroundColor(.red)
            }
            Button(action: {signUp()}) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(5.0)
            }
        }
        .padding(.top, 30)
        .padding()
    }
    
    private func signUp() {
        state.shouldIndicateActivity = true
        print("Email: \(email)")
        print("Password: \(password)")
        
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            state.shouldIndicateActivity = false
            return
        }
        if password != confirmPassword {
            state.shouldIndicateActivity = false
            return
        }
        
        self.state.error = nil
        app.emailPasswordAuth.registerUser(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                state.shouldIndicateActivity = false
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    self.state.error = error.localizedDescription
                }
            }, receiveValue: {
                self.state.error = nil
                signIn()
            })
            .store(in: &state.cancellables)
    }
    
    private func signIn() {
        self.state.error = nil
        state.shouldIndicateActivity = true
        app.login(credentials: .emailPassword(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                state.shouldIndicateActivity = false
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    self.state.error = error.localizedDescription
                }
            }, receiveValue: {
                self.state.error = nil
                state.loginPublisher.send($0)
            })
            .store(in: &state.cancellables)
    }
}
