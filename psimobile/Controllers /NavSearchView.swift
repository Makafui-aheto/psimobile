//
//  NavSearchView.swift
//  Psi
//
//  Created by Makafui Aheto on 06/09/2021.
//

import SwiftUI
import UIKit

struct NavSearchView: UIViewControllerRepresentable{
    
    
    func makeCoordinator() -> Coordinator {
        return NavSearchView.Coordinator(parent:self)
    }
    
    
    var view:  AnyView
    
    var onSearch: (String)->()
    var onCancel: () -> ()
    
    init(view: AnyView, onSearch: @escaping (String)->(), onCancel: @escaping ()->()){
        self.view = view
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    func makeUIViewController(context: Context) ->UINavigationController{
        
        let childView = UIHostingController(rootView: view)
        let controller = UINavigationController(rootViewController: childView)
        controller.navigationBar.backIndicatorImage?.accessibilityElementsHidden = true
        
        
        //inserting searchbar
        
        let searchBarController = UISearchController()
        searchBarController.searchBar.placeholder = "Search Courses"
        
        searchBarController.searchBar.delegate = context.coordinator
        
        searchBarController.obscuresBackgroundDuringPresentation = false
        
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        controller.navigationBar.topItem?.searchController = searchBarController
        
        
        return controller
    }
    
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UISearchBarDelegate{
        var parent: NavSearchView
        
        init(parent: NavSearchView){
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            self.parent.onSearch(searchText)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.parent.onCancel()
        }
    }
    
}
    

