//
//  Resources.swift
//  Daily COVID Screening
//
//  Created by Rahul Sura on 4/30/22.
//

import Foundation
import SwiftUI
import SafariServices

// Resources section of app
struct Resources: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView {
            VStack(alignment: .center){ // resource list
                (colorScheme == .light ? Image("Chapman Logo") : Image("Dark Chapman Logo")) // dark mode logo
                    .resizable()
                    .frame(width: 250, height: 48)
                Text("Chapman COVID Resources")
                    .font(.title)
                    .padding(.vertical)
                Divider()
                VStack{
                    LinkListItem(label: "(Alternative) Chapman's", linkText: "AM I CLEAR", link: "https://www.chapman.edu/amiclear")
                    Divider()
                    LinkListItem(label: "Main Website:", linkText: "CU Back Safely", link: "https://cusafelyback.chapman.edu/")
                    LinkListItem(label: "Public Health", linkText: "OC Guidelines", link: "https://occovid19.ochealthinfo.com/")
                    LinkListItem(label: "Policy:", linkText: "Masks Indoors", link: "https://cusafelyback.chapman.edu/masks-recommended-indoors-for-both-vaccinated-and-unvaccinated-indivduals/")
                    LinkListItem(label: "Vaccinated?", linkText: "Register your vaccine", link: "https://web.chapman.edu/covid19vaccination")
                    LinkListItem(label: "Not vaccinated?", linkText: "Learn about weekly testing", link: "https://cusafelyback.chapman.edu/twice-weekly-covid-19-testing-effective-aug-16th/")
                    LinkListItem(label: "Return to campus:", linkText: "Follow these Steps", link: "https://cusafelyback.chapman.edu/return-to-campus-processes-for-faculty-staff-students-prospective-families-visitors/")
                    LinkListItem(label: "COVID-19 Dashboard:", linkText: "Exposure in Facilities", link: "https://cusafelyback.chapman.edu/dashboard#pen")
                }
                
                Spacer()
            }.padding()
        }
    }
}

struct Resources_Previews: PreviewProvider {
    static var previews: some View {
        Resources()
    }
}
