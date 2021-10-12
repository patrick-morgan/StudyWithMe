//
//  SignInView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/22/21.
//

import SwiftUI
import RealmSwift

struct SignInView: View {
    
    @EnvironmentObject var state: AppState
    
    @State var email: String = ""
    @State var password: String = ""
    @State var authFailed: Bool = false
    @State var authSucceeded: Bool = false
    @State var isLoading: Bool = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                LogoView()
                LoginView(email: $email, password: $password, authFailed: $authFailed)
                Spacer()
                Divider()
                HStack {
                    Text("Don't have an account?")
                    NavigationLink("Sign Up", destination: SignUpView())
                }
                .font(.footnote)
                .padding(.top, 10)
            }
            .padding(.top, -70)
        }
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AppState())
    }
}

struct LogoView: View {
    var body: some View {
        Image("StudyLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 250)
            .clipped()
        Text("Study With Me")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.top, -50)
    }
}

struct LoginView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var authFailed: Bool
    @State var errorText: String = ""
    @EnvironmentObject var state: AppState

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 5)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity)
            if authFailed {
                Text(errorText)
                    .offset(y: -10)
                    .foregroundColor(.red)
            }
            Button(action: { signIn() }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(5.0)
            }
        }
        .padding(.top, 30)
    }
    
    private func signIn() {
        state.shouldIndicateActivity = true
        print("Signing In")
        print("Email: \(email)")
        print("Password: \(password)")
//        print("errorText: \(errorText)")
//        print("errorText: \(self.errorText)")
//        self.userRealmConfiguration.score += 1
//        print(self.userRealmConfiguration.score)
//        userRealmConfiguration.score += 1
//        print(userRealmConfiguration.score)
        
        if email.isEmpty || password.isEmpty {
            state.shouldIndicateActivity = false
            return
        }
        self.state.error = nil
        
        app.login(credentials: Credentials.emailPassword(email: email, password: password))
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
