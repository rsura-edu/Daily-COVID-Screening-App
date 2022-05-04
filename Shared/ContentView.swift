//
//  ContentView.swift
//  Shared
//
//  Created by Rahul Sura on 4/24/22.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("email") private var email: String = ""
    @AppStorage("dateLastSurvey") private var dateLastSurvey : Date = Date.distantPast
    @AppStorage("isClearLastSurvey") private var isClearLastSurvey : Bool = true
    @State private var currPage: Int = 1
//    @Environment (\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors:[]) private var infoCD: FetchedResults<InfoCD>
    
    var body: some View {
        
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
        
        var todayScreen: AnyView = AnyView(Screening())
        let rightNow = Date()
        
        if dateLastSurvey.get(.year) == rightNow.get(.year) && dateLastSurvey.get(.month) == rightNow.get(.month) &&
            dateLastSurvey.get(.day) == rightNow.get(.day){

            if isClearLastSurvey {
                todayScreen = AnyView(ClearScreen())
            } else {
                todayScreen = AnyView(NotClearScreen())
            }
        }
        
        return TabView(selection: $currPage){
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
