//
//  ContentView.swift
//  Shared
//
//  Created by Rahul Sura on 4/24/22.
//

import SwiftUI
import SafariServices
import UserNotifications

// Main content view. Has 3 tabs
struct ContentView: View {
    // name and email and most recent date of filled survey to be used for screening
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("email") private var email: String = ""
    @AppStorage("dateLastSurvey") private var dateLastSurvey : Date = Date.distantPast
    @AppStorage("isClearLastSurvey") private var isClearLastSurvey : Bool = true
    @State private var currPage: Int = 1 // first page is current tab
    @Environment(\.colorScheme) var colorScheme // dark mode
    var body: some View {
        var todayScreen: AnyView = AnyView(Screening()) // normal screening view
        let rightNow = Date()
        
        if dateLastSurvey.get(.year) == rightNow.get(.year) && dateLastSurvey.get(.month) == rightNow.get(.month) && dateLastSurvey.get(.day) == rightNow.get(.day){ // checks if the date of the last survey was today to show the appropriate next view
            
            if firstName != "" && lastName != "" && email != ""{
                if isClearLastSurvey { // if clear
                    todayScreen = AnyView(ClearScreen())
                } else { // if not clear
                    todayScreen = AnyView(NotClearScreen())
                }
            } else { // if profile info was removed after filling the survey out
                todayScreen = AnyView(removedProfile())
            }
        }
        
        return TabView(selection: $currPage){ // main tab view
            todayScreen
                .tabItem{
                    Image(systemName: "clock")
                    Text("Daily Screening")
                }.tag(1)
            Resources()
                .tabItem{
                    Image(systemName: "list.bullet.rectangle.portrait")
                    Text("Resources")
                }.tag(2)
            Profile()
                .tabItem{
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(3)
        }
    }
}

// Link to open in app browser formatted in an HStack, centered
struct LinkListItem: View{
    @State public var label: String
    @State public var linkText: String
    @State public var link: String
    @State private var showSafari: Bool = false
    var body: some View{
        HStack{
            Spacer()
            Text(label)
            Text(linkText)
                .foregroundColor(.blue)
                .onTapGesture {
                    showSafari.toggle()
                }
                .fullScreenCover(isPresented: $showSafari, content: {
                    SFSafariViewWrapper(url: URL(string: link)!)
                })
            Spacer()
        }
        .padding(.vertical)
    }
}


// in app safari view
struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
