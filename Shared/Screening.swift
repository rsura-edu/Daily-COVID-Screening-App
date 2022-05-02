//
//  Screening.swift
//  Daily COVID Screening
//
//  Created by Rahul Sura on 4/30/22.
//

import SwiftUI

struct Screening: View {
    var yesOrNo = ["Yes","No"]
    @State private var selectedCategory = 1
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading){
                    Questions()
                    Picker("",selection: $selectedCategory){
                        ForEach(0 ..< yesOrNo.count){
                            Text(self.yesOrNo[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .frame(height: 70, alignment: .center)
                        .pickerStyle(SegmentedPickerStyle())
                    
                    NavigationLink(destination: selectedCategory == 1 ? AnyView(ClearScreen()
                        .navigationBarBackButtonHidden(Bool(true))) : AnyView(NotClearScreen()
                            .navigationBarBackButtonHidden(Bool(true)))
                    ) {
                        Text("Submit")
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
                        //                    Button(action: {
                        //
                        //                    }) {
                        
                        
                        //                    }
                        
                    }
                    
                    
                }
                .padding()
            }
        }
        //        .navigationBarTitle("")
        //        .navigationBarHidden(true)
        
    }
    
}

struct ClearScreen: View{
    var body: some View{
        VStack{
            Text("CLEAR")
                .foregroundColor(.green)
        }
    }
}

struct NotClearScreen: View{
    var body: some View{
        VStack{
            Text("NOT CLEAR")
                .foregroundColor(.red)
        }
    }
}

struct Questions: View {
    @State private var showSafari: Bool = false
    var body: some View {
        VStack(alignment: .leading){
            Image("Chapman Logo")
                .resizable()
                .frame(width: 250, height: 48, alignment: .center)
            Text("Are any of the following true for you?")
                .font(.title3)
                .padding(.vertical)
            (Text("1. I am sick with ") +
             Text("COVID-19 symptoms")
                .foregroundColor(.blue))
            .onTapGesture {
                showSafari.toggle()
            }
            .fullScreenCover(isPresented: $showSafari, content: {
                SFSafariViewWrapper(url: URL(string: "https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html")!)
            })
            .padding([.leading, .bottom])
            Text("2. I have been notified that I am COVID-19 positive or have come in close* contact with someone who has or is suspected of having COVID-19")
                .padding([.leading, .bottom, .trailing])
            (Text("3. I have a ") +
             Text("temperature")
                .foregroundColor(.blue) +
             Text(" of 100.4 degrees F (or 38 C) or greater")
            )
            .onTapGesture {
                showSafari.toggle()
            }
            .fullScreenCover(isPresented: $showSafari, content: {
                SFSafariViewWrapper(url: URL(string: "https://www.cdc.gov/quarantine/air/reporting-deaths-illness/definitions-symptoms-reportable-illnesses.html")!)
            })
            .padding([.horizontal, .bottom])
            Text("*Close contact means that you have been within six feet of a COVID-19 positive individual for at least 15 minutes cumulative within a 24 hour period.")
                .padding(.horizontal)
            
        }
    }
}

struct Screening_Previews: PreviewProvider {
    static var previews: some View {
        Screening()
    }
}
