//
//  RestarurantCarouselView.swift
//  TravelDiscoveryLTBA
//
//  Created by oguzhan on 19.05.2024.
//

import SwiftUI
import Kingfisher

struct RestarurantCarouselView: UIViewControllerRepresentable {
    
    let imageUrlStrings: [String]
    let selectedIndex: Int
    
    func makeUIViewController(context: Context) ->  UIViewController {
        
        let pvc = CarouselPageViewController(imageUrlStrings: imageUrlStrings,selectedIndex: selectedIndex)
        return pvc
    }
    
    typealias UIViewControllerType = UIViewController
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

class CarouselPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var allControllers: [UIViewController]  = []
    var selectedIndex: Int
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        selectedIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController)
        else  { return nil }
        
        if index == 0 { return nil }
        
        return allControllers[index - 1]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = allControllers.firstIndex(of: viewController)
        else  { return nil }
        
        if index == allControllers.count - 1 { return nil }
        
        return allControllers[index + 1]
    }
    
    
    init(imageUrlStrings: [String], selectedIndex: Int){
        self.selectedIndex = selectedIndex
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .orange
        
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        
        allControllers = imageUrlStrings.map({ imageName in
            let hostingController = UIHostingController(
                rootView:
                    ZStack{
                        Color.black
                        KFImage(URL(string: imageName))
                        .resizable()
                        .scaledToFit()
                    }
            )
            
            hostingController.view.clipsToBounds = true
            return hostingController
        })
        
        if selectedIndex < allControllers.count{
            setViewControllers([allControllers[selectedIndex]], direction: .forward, animated: true,completion: nil)
        }

        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    RestarurantCarouselView(imageUrlStrings: imageUrlString,selectedIndex: 5)
}
