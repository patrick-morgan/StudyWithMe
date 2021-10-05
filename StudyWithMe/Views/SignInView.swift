//
//  SignInView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/22/21.
//

import SwiftUI
import RealmSwift

struct SignInView: View {
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
    @EnvironmentObject var userRealmConfiguration: UserRealmConfiguration

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 5)
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
        print("Signing In")
        print("Email: \(email)")
        print("Password: \(password)")
//        print("errorText: \(errorText)")
//        print("errorText: \(self.errorText)")
//        self.userRealmConfiguration.score += 1
//        print(self.userRealmConfiguration.score)
//        userRealmConfiguration.score += 1
//        print(userRealmConfiguration.score)
        
        app.login(credentials: Credentials.emailPassword(email: email, password: password)) { (result) in
            // Completion handlers are not necessarily called on the UI thread.
            // This call to DispatchQueue.main.async ensures that any changes to the UI,
            // namely disabling the loading indicator and navigating to the next page,
            // are handled on the UI thread:
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
                    errorText = "Login failed: \(error.localizedDescription)"
                    authFailed = true
                    return
                case .success(let user):
                    print("Login succeeded!")
                    // Get Realm configuration so we can open the synced realm
                    let configuration = user.configuration(partitionValue: user.id)
                    // Open the realm asynchronously so that it downloads the remote copy before
                    // opening the local copy.
                    Realm.asyncOpen(configuration: configuration) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .failure(let error):
                                fatalError("Failed to open realm: \(error)")
                            case .success:
                                // Set configuration to environment object
                                print("success")
                                userRealmConfiguration.configuration = configuration
                                userRealmConfiguration.signedIn = true
                            }
                        }
                    }
                }
            }
        }
    }
}
