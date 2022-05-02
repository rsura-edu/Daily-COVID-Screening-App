//
//  ContentView.swift
//  Shared
//
//  Created by Rahul Sura on 4/24/22.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    @State private var currPage = 1
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
