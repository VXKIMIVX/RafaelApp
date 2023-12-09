//
//  ContentView.swift
//  For Makers Only
//
//  Created by Tagart,Will on 12/9/23.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

//
//  ContentView.swift
//  ForMakersOnly
//
//  Created by xcodeday on 12/8/23.
//

import SwiftUI
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding([.leading, .trailing], 10)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
}
extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0,
            opacity: 1.0)
    }
}

struct FontNameManager {
    struct Montserrat {
        static let bold = "Montserrat-ExtraBold"
    }
}

struct FontNameManagers {
    struct Montserrat {
        static let thin = "Montserrat-Thin100"
    }
}

let heading = Font.custom(FontNameManager.Montserrat.bold, size:UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)

let miniheading = Font.custom(FontNameManager.Montserrat.bold, size:UIFont.preferredFont(forTextStyle: .headline).pointSize)

let WebsiteURL = "https://www.candlemakingsupplies.net/shop/vessel/14-oz-havana-champagne-candle-jar"

struct Page1View: View {
    var body: some View {
        Text("Hello")
    }
}
struct Page2View: View {
    var body: some View {
        Text("Hello")
    }
}
struct Page3View: View {
    var body: some View {
        Text("Hello")
    }
}
struct Page4View: View {
    var body: some View {
        Text("Hello")
    }
}
struct Page5View: View {
    var body: some View {
        Text("Hello")
    }
}
struct Page6View: View {
    var body: some View {
        Text("Hello")
    }
}


struct ProductsView: View {
    @State private var searchText = ""
    let allProducts = (1..<7).map { "Product \($0)" }

    var filteredProducts: [String] {
        if searchText.isEmpty {
            return allProducts
        } else {
            return allProducts.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            
            Text("Full Product List")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()
            
            let gridItems = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
            
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(filteredProducts, id: \.self) { product in
                        NavigationLink(destination: getPageViewForProduct(product)) {
                            VStack {
                                Image("image\(product.last!)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                Text(product)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
        func getPageViewForProduct(_ product: String) -> some View{
            guard let productNumber = Int(String(product.last ?? "1")) else {
                return AnyView(EmptyView())
            }
            switch productNumber {
            case 1:
                return AnyView(Page1View())
            case 2:
                return AnyView(Page2View())
            case 3:
                return AnyView(Page3View())
            case 4:
                return AnyView(Page4View())
            case 5:
                return AnyView(Page5View())
            case 6:
                return AnyView(Page6View())
            default:
                return AnyView(EmptyView())
            }
        }
    }

    func getPageViewForImage(_ imageNumber: Int) -> some View {
        switch imageNumber {
           
            case 1:
                return AnyView(Page1View())
            case 2:
                return AnyView(Page2View())
            case 3:
                return AnyView(Page3View())
            case 4:
                return AnyView(Page4View())
            case 5:
                return AnyView(Page5View())
            case 6:
                return AnyView(Page6View())
            default:
                return AnyView(EmptyView())
            
        }
    }
    func getPageViewForProduct(_ product: String) -> some View {
        // Implement logic to return the appropriate view based on the selected product
        // Example: return a specific view based on the product name or ID
        return Text("Product Detail View for \(product)")
    }

                        

struct ContentView:View { //Changed from ContentView (Ken)
    //@State private var choiceMade = 0
    
    let backgroundColor = Color(hex: 0xEDE7DF)
    let stateOptions=["Select State", "MI", "CA", "NV", "NY"]
    @State private var selectedStateIndex = 0
    
    var body: some View {
        NavigationView {
            
            VStack  {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("TAYLOR CANDLE & CO")
                    .font(heading)
                Text("“When life gives you wax, wick it”")
                    .font(miniheading)
                    .padding(.bottom, 20)
                
                Picker("Select a state", selection: $selectedStateIndex){
                    ForEach(0..<stateOptions.count, id: \.self){ index in
                        Text(self.stateOptions[index])}
                }
                .pickerStyle(MenuPickerStyle())
                
                if selectedStateIndex != 0 {
                    NavigationLink(destination: AllProductsView()) {
                        Text("Next")
                            .font(miniheading)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                } else {
                    Text("Please select a state first.")
                        .font(miniheading)
                        .foregroundColor(.red)
                        .padding(.bottom, 20)
                }
                
            }
        }
        
    }
}

struct AllProductsView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)

                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(filteredProducts, id: \.self) { product in
                            ProductItemView(product: product)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("All Products")
        }
    }

    var filteredProducts: [String] {
        if searchText.isEmpty {
            return allProducts
        } else {
            return allProducts.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    

    let allProducts = [

        "14 OZ Vessel",
        "9.5 OZ Vessel",
        "Wax",
        "Cotton Wicks",
        "Custom Tape",
        "Wick Stickers",
        "Fragrance Oils",
        "Vessels"
        // Add other product names as needed
    ]

    struct ProductItemView: View {
        let product: String

        var body: some View {
            VStack {
                Image("image1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:250, height: 250)
                Text("9.5 OZ Vessel")
                
                Image("image\(product.last!)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)

                Text(product)
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
    }
}

            

//NEW YORK PAGE
struct NYProductsView:View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Page 2")
                Button(action: {
                    //putting website URL
                    if let url = URL(string: WebsiteURL) { UIApplication.shared.open(url)}
                }) {
                    Text("Visit Website")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(8.0)
                }
                .padding()
            }
        }
    }
}

//NEVADA PAGE
    struct NVProductsView:View {
        var body: some View {
            VStack {
                Text("Page 3")
                
                Button(action: {
                    //putting website URL
                    if let url = URL(string: WebsiteURL) { UIApplication.shared.open(url)}
                }) {
                    Text("Visit Website")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(8.0)
                }
                .padding(.top,20)
            }
        }
    }
//CALIFORNIA PAGE
    struct CAProductsView:View {
        var body: some View {
            VStack {
                Image("image2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:150, height: 150)
                Text("14 OZ Vessel")
                
                Button(action: {
                    //putting website URL
                }) {
                    Image("image1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                    Text("test")
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(8.0)
                }
                .padding(.top,20)
                
                Image("image1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:250, height: 250)
                Text("9.5 OZ Vessel")
            
                    Button(action: {
                        //putting website URL
                        if let url = URL(string: WebsiteURL) { UIApplication.shared.open(url)}
                    }) {
                        Text("Visit Website")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(8.0)
                    }
                    .padding(.top,20)
            }
        }
    }
    
//MICHIGAN PAGE
    struct MIProductsView:View {
        var body: some View {
            VStack {
                Text("Page 5")
                
                Button(action: {
                    //putting website URL
                    if let url = URL(string: WebsiteURL) { UIApplication.shared.open(url)}
                }) {
                    Text("Visit Website")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(8.0)
                }
                .padding(.top,20)
            }
        }
    }
    
    struct NotesView: View {
        @State private var text: String = ""
        var body: some View {
            VStack {
                Text("lol")
                
                TextEditor(text: $text)
                    .frame(minHeight: 100)
                    .padding()
                    .border(Color.gray, width: 1)
            }
            .padding()
        }
    }
struct Page1View_Previews:
    PreviewProvider {
    static var previews: some
    View{
        Page1View()
    }
}
    
#Preview {
    ContentView()
}
