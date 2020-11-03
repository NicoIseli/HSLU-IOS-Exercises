//
//  ContentView.swift
//  Swift-UI
//
//  Created by nico on 02.11.20.
//

import SwiftUI





// MARK: - Content View

// Main View where all the components are included
struct ContentView: View {
    
    // States
    @State var start = Date()
    @State var laps: [Date] = []
    @State var counter = 0
    
    // Observed Objects
    @ObservedObject var imageLoader = ImageLoader.shared
    
    var body: some View {
        Form{
            Section(header: Text("Commands")){
                Button("Reset"){
                    start = Date()
                    laps = []
                    counter = 0
                }
                Button("Lap"){
                    laps.append(Date())
                    counter += 1
                }
            }
            
            Section(header: Text("Output")){
                Text("\(counter) lap").bold()
                ForEach(laps, id: \.self){
                    row in
                    RowView(startDate: start, labDate: row)
                }
            }
            
            Section(header: Text("Image")){
                Image(uiImage: imageLoader.image!).resizable().aspectRatio(contentMode: .fit)
            }
        }
    }
}





// MARK: - Row View

// View whicht defines the content of a row
struct RowView: View{
    
    let startDate: Date
    let labDate: Date
    
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(secondGenerator(startDate: startDate, labDate: labDate))
                Text(labDate, style: .time)
            }
            Spacer()
            Image(systemName: "timer")
        }
    }
    
    func secondGenerator(startDate: Date, labDate: Date) -> String {
        
        let difference = Calendar.current.dateComponents([.second], from: startDate, to: labDate)
        
        let seconds = difference.second
        
        return String(seconds!) + " sec"
    }
    
}





// MARK: - Preview

// View to enable preview in XCode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





// MARK: - Image Loader

// Class that gets and holds an image requested from a specific URL
class ImageLoader: ObservableObject {
    
    static let shared = ImageLoader()
    
    @Published var image: UIImage?
    
    let url = URL(string: "https://images.unsplash.com/photo-1544126886-85162ac4991e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80")
    
    init() {
        
        do{
            let data = try Data(contentsOf: self.url!)
            
            image = UIImage(data: data)
            
        } catch {
            print("Image could not be loaded!")
        }
    }
}
