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
    @EnvironmentObject var userRealmConfiguration: UserRealmConfiguration

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("First name", text: $firstName)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
            TextField("Last name", text: $lastName)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
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
        print("Email: \(email)")
        print("Password: \(password)")
//        email = "fish"
//        password = "blob"
//        loading = true
//        app.emailPasswordAuth.registerUser(email: email, password: password)
        
        app.emailPasswordAuth.registerUser(email: email, password: password) { (error) in
            // Completion handlers are not necessarily called on the UI thread.
            // This call to DispatchQueue.main.async ensures that any changes to the UI,
            // namely disabling the loading indicator and navigating to the next page,
            // are handled on the UI thread:
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Signup failed: \(error!)")
                    return
                }

                // Successful
                print("Successfully registered user.")
                signIn()
            }
        }
    }
    
    private func signIn() {
        app.login(credentials: Credentials.emailPassword(email: email, password: password)) { (result) in
            // Completion handlers are not necessarily called on the UI thread.
            // This call to DispatchQueue.main.async ensures that any changes to the UI,
            // namely disabling the loading indicator and navigating to the next page,
            // are handled on the UI thread:
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
//                    errorText = "Login failed: \(error.localizedDescription)"
//                    authFailed = true
                    // Navigate to Home Screen
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
