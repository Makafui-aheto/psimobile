//
//  ScrollableTab.swift
//  Psi
//
//  Created by Makafui Aheto on 03/09/2021.
//

import SwiftUI

struct ScrollableTab <Content: View>: UIViewRepresentable{


    var content: Content

    var rect: CGRect

    var tabs: [Any]

    @Binding var offset: CGFloat

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    let scrollView = UIScrollView()
    
    init(tabs:[Any], rect: CGRect, offset: Binding<CGFloat>, @ViewBuilder content: ()-> Content){
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
        
    }
    
    func makeCoordinator() -> Coordinator {
        return ScrollableTab.Coordinator(parent: self)
    }
    
    func makeUIView(context:Context) -> some UIView{
        setUpScrollView()
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height:rect.height)
        scrollView.addSubview(extractView())
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func setUpScrollView(){
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator  = false
        scrollView.showsHorizontalScrollIndicator = false
    
    }
    
    func updateUIVidew(_ uiView: UIScrollView, context: Context) {
        if uiView.contentOffset.x != offset{
            uiView.contentOffset.x = offset
        }
    }
    
    
    func extractView()->UIView{
        let controller = UIHostingController(rootView: content)
        controller.view.frame = CGRect(x:0, y:0, width:rect.width * CGFloat(tabs.count), height:rect.maxY)
        return controller.view!
        
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate{
        
        var parent: ScrollableTab
        
        init(parent: ScrollableTab){
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
            scrollView.contentOffset.y = 0.0
        }
    }

}

struct ScrollableTab_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .padding(-2)
    }
}
