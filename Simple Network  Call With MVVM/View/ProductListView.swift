//
//  ProductListView.swift
//  Simple Network  Call With MVVM
//
//  Created by Ale on 23/08/2023.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.productsData?.products ?? []) { data in
                HStack(spacing: 20) {
                    
                    AsyncImage(url: URL(string: data.thumbnail ?? "")) { image in
                        image
                            .resizable().aspectRatio(contentMode: .fill).clipShape(Circle())
                    } placeholder: {
                        Circle().foregroundColor(.gray)
                    }
                    .frame(width: 100, height: 100) //Product Image
                    
                    VStack(alignment: .leading ,spacing: 10){
                        
                        Text(data.title ?? "")
                            .fontWeight(.semibold) //Product Title
                        
                        Text(data.description ?? "")
                            .fontWeight(.light)
                            .foregroundColor(.gray) //Product Description
                    }
                } //HStack
            } //List
            .task {
                do{
                    try await viewModel.getProductsList()
                }catch NetworkError.invalidData{
                    print("Invalid Data")
                }catch NetworkError.invalidResponse{
                    print("Invalid Response")
                }catch NetworkError.invalidURLString{
                    print("Invalid URL String")
                }catch {
                    print("Unknown Error")
                }
            }
            .navigationTitle("Products List")
        } //NavigationView
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
