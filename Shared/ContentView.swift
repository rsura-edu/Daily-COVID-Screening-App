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
    @AppStorage("dateLastSurvey") private var dateLastSurvey : Date = Date()
    @AppStorage("isClearLastSurvey") private var isClearLastSurvey : Bool = true
    @State private var currPage: Int = 1
//    @Environment (\.managedObjectContext) private var viewContext
//    @FetchRequest(sortDescriptors:[]) private var infoCD: FetchedResults<InfoCD>
    
    var body: some View {
        TabView(selection: $currPage){
            Screening()
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
