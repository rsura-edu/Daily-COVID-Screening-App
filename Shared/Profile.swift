//
//  Profile.swift
//  Daily COVID Screening
//
//  Created by Rahul Sura on 5/1/22.
//

import SwiftUI

struct Profile: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    
    var body: some View {
        VStack{
            Form{
                HStack {
                    Spacer()
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100, alignment: .center)
                    .padding()
                    Spacer()
                }
                DataInput(title: "First Name", userInput: $firstName)
                DataInput(title: "Last Name", userInput: $lastName)
                VStack(alignment: HorizontalAlignment.leading) {
                    (Text("Chapman Email Address")  + Text("*").foregroundColor(.red))
                        .font(.headline)
                    HStack {
                        TextField("Enter Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("@chapman.edu")
                    }
                }
                .padding()
                VStack{
                    Text(message).foregroundColor(.red)
                    Button(action: {
                        print("\(firstName) \(lastName)'s Chapman Email: \(email)@chapman.edu")
                        updateDatabase()
                    }){
                        Text("Update")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 20))
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }
                
            }
            
        }
    }
    
    func updateDatabase(){
        if (firstName == "" || lastName == "" || email == "") {
            message = "Please ensure to fill each field"
        } else {
            message = ""
        }
    }
}

//: Takes in a string data type and stores it using binding variables
struct DataInput: View {
    var title: String
    @Binding var userInput: String
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            (Text(title) + Text("*").foregroundColor(.red))
                .font(.headline)
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .previewInterfaceOrientation(.portrait)
    }
}


