//
//  CarouselVC.swift
//  iOSJanAssignment
//
//  Created by Mounika Ankeswarapu on 25/01/25.
//

import UIKit

class CarouselVC: UIViewController {

    @IBOutlet weak var carouselTableView: UITableView!
    
    var carouselItems:[CarouselStruct]?
    var allItems:[List]?
    var filteredItems:[List]?
    var pageControl = UIPageControl()
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let jsonData = loadJson(filename: "Carousel") else { return }
        self.carouselItems = jsonData
        self.allItems = jsonData.first?.list
        self.filteredItems = jsonData.first?.list
        
        self.carouselTableView.delegate = self
        self.carouselTableView.dataSource = self
        self.carouselTableView.register(UINib(nibName: "EachRowTVCell", bundle: nil), forCellReuseIdentifier: "EachRowTVCell")
        setupTableHeaderView()
    }
    
    func loadJson(filename fileName: String) -> [CarouselStruct]? {
        guard let url = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([CarouselStruct].self, from: data)
            return jsonData
        } catch {
            //print("error:\(error)")
            return nil
        }
    }
    

    func setupTableHeaderView() {
        // Create a UIView to hold the header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 230))
       
        // Configure the carousel collection view
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = CGSize(width: view.frame.width, height: 200)
        carouselLayout.minimumLineSpacing = 0

        let carouselCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200), collectionViewLayout: carouselLayout)
        carouselCollectionView.isPagingEnabled = true
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.register(UINib(nibName: "HeadingImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeadingImageCollectionViewCell")
        headerView.addSubview(carouselCollectionView)

        // Add Page Control
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 210, width: view.frame.width, height: 30))
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = carouselItems?.count ?? 0
        pageControl.currentPage = 0
        pageControl.tintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .systemBlue // Color for the active page dot
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.6)
        pageControl.subviews.forEach { dot in
            dot.transform = CGAffineTransform(scaleX: 1.5, y: 1.5) // Scale up the dots (1.5x size)
        }
        headerView.addSubview(pageControl)

        // Set header view to the table view
        carouselTableView.tableHeaderView = headerView
    }

    // UICollectionView Delegate Method

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Check if the scrollView is the carousel collection view
        if let carouselCollectionView = scrollView as? UICollectionView {
            let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            self.pageControl.currentPage = currentIndex
            self.allItems = self.carouselItems?[currentIndex].list
            self.filteredItems = self.allItems
            self.searchBar.text = ""
            DispatchQueue.main.async {
                self.carouselTableView.reloadData()
            }
        }
    }

}

extension CarouselVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carouselItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadingImageCollectionViewCell", for: indexPath) as? HeadingImageCollectionViewCell else { return UICollectionViewCell() }
        cell.headingImg.layer.cornerRadius = 15
        if let image = self.carouselItems?[indexPath.item].image{
            cell.headingImg.image = UIImage(named: image)
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if carouselItems?.count == 1 {
//            let cellWidth = collectionView.frame.size.width - 10
//            let cellHeight: CGFloat = collectionView.frame.size.height
//            return CGSize(width: cellWidth, height: cellHeight)
//        }else {
//            let cellWidth = collectionView.frame.size.width - 50.0
//            let cellHeight: CGFloat = collectionView.frame.size.height
//            return CGSize(width: cellWidth, height: cellHeight)
//        }
//    }
            
}

extension CarouselVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EachRowTVCell", for: indexPath) as? EachRowTVCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.typeImageView.layer.cornerRadius = cell.typeImageView.frame.height / 2
        
        // Configure the cell
        if let item = filteredItems?[indexPath.row]{
            cell.typeImageView?.image = UIImage(named: item.image ?? "")
            cell.typeNameLabel?.text = item.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create a UIView to act as the header
        let sectionHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        sectionHeader.backgroundColor = .white

        // Add a UISearchBar to the section header
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: sectionHeader.frame.width, height: 50))
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        sectionHeader.addSubview(searchBar)

        return sectionHeader
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }

}

extension CarouselVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredItems = allItems
        } else {
            filteredItems = allItems?.filter { $0.name?.lowercased().contains(searchText.lowercased()) == true }
        }
        self.carouselTableView.reloadData()
    }
}


