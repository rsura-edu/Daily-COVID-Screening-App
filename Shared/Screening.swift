//
//  Screening.swift
//  Daily COVID Screening
//
//  Created by Rahul Sura on 4/30/22.
//

import SwiftUI

struct Screening: View {
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("email") private var email: String = ""
    @AppStorage("dateLastSurvey") private var dateLastSurvey : Date = Date.distantPast
    @AppStorage("isClearLastSurvey") private var isClearLastSurvey : Bool = true
    let yesOrNo = ["Yes","No"]
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
                        .frame(height: 40, alignment: .center)
                        .pickerStyle(SegmentedPickerStyle())
                    
                    if (firstName == "" || lastName == "" || email == "") {
                        Text("Please ensure to go to the Profile Section to update your info before filling out your COVID Screening")
                            .foregroundColor(.red)
                    } else {
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
                        .simultaneousGesture(TapGesture().onEnded {
                            dateLastSurvey = Date()
                            isClearLastSurvey = (selectedCategory != 0)
                            
                            print(dateLastSurvey)
                            print("Year: \(dateLastSurvey.get(.year)), Month: \(dateLastSurvey.get(.month)), Day: \(dateLastSurvey.get(.day)), Hour: \(dateLastSurvey.get(.hour)), Minute: \(dateLastSurvey.get(.minute)), Second: \(dateLastSurvey.get(.second))")
                        })
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
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("email") private var email: String = ""
    @AppStorage("dateLastSurvey") private var dateLastSurvey : Date = Date.distantPast
    @AppStorage("isClearLastSurvey") private var isClearLastSurvey : Bool = true
    var body: some View{
        VStack{
            Text("CLEAR")
                .foregroundColor(.green)
        }
    }
}

struct NotClearScreen: View{
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("email") private var email: String = ""
    @AppStorage("dateLastSurvey") private var dateLastSurvey : Date = Date.distantPast
    @AppStorage("isClearLastSurvey") private var isClearLastSurvey : Bool = true
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
            (Text("1.").fontWeight(.bold) + Text(" I am sick with ") +
             Text("COVID-19 symptoms")
                .foregroundColor(.blue))
            .onTapGesture {
                showSafari.toggle()
            }
            .fullScreenCover(isPresented: $showSafari, content: {
                SFSafariViewWrapper(url: URL(string: "https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html")!)
            })
            .padding(.leading)
            (Text("2.").fontWeight(.bold) + Text(" I have been notified that I am COVID-19 positive or have come in close") + Text("*").fontWeight(.bold) + Text(" contact with someone who has or is suspected of having COVID-19"))
                .padding(.horizontal)
            (Text("3.").fontWeight(.bold) + Text(" I have a ") +
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
            (Text("*").fontWeight(.bold) + Text("Close contact means that you have been within six feet of a COVID-19 positive individual for at least 15 minutes cumulative within a 24 hour period."))
                .padding(.horizontal)
            Spacer()
        }
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

struct Screening_Previews: PreviewProvider {
    static var previews: some View {
        Screening()
    }
}
