//
//  ProductsViewModel.swift
//  Simple Network  Call With MVVM
//
//  Created by Ale on 23/08/2023.
//

import Foundation

class ProductsViewModel: ObservableObject{
    
    @Published var productsData: ProductsDataModel?
    
    //MARK: - Custom Methods API Calls -
    
    func getProductsList() async throws {
        productsData = try await NetworkManager.shared.fetchData(for: ProductsDataModel.self, from: "https://dummyjson.com/products")
    }
    
}
