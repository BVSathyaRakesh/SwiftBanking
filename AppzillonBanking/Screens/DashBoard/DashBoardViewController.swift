//
//  DashBoardViewController.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/14.
//

import UIKit

struct DashBoardItemModel {
    var icon: UIImage
    var title: String
}

private struct Constants {
    static let SectionSpacing: CGFloat = 15
    static let NumberOfCellsInARow: CGFloat = 2
}


class DashBoardViewController: UIViewController {
    
    var viewModel = DashBoardViewModel()
    private var currentPage = 0
    var userDetailsArray = [AnyObject]()
    
    private var collectionsView: UICollectionView?
    private var tabCollectionsView: UICollectionView?
    
    var loadingView = LoadingView()
    
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.isUserInteractionEnabled = true
        control.currentPageIndicatorTintColor = .systemBlue
        control.pageIndicatorTintColor = .gray
        return control
    }()
    
       
    var menu: [DashBoardItemModel] = [
        DashBoardItemModel(icon: UIImage(named: "Accounts")!, title: "Accounts"),
        DashBoardItemModel(icon: UIImage(named: "Statement")!, title: "Statements"),
        DashBoardItemModel(icon: UIImage(named: "Transfer")!, title: "Transfer"),
        DashBoardItemModel(icon:  UIImage(named: "Notification")!, title: "Notification"),
        DashBoardItemModel(icon: UIImage(named: "call")!, title: "Phone Call"),
        DashBoardItemModel(icon: UIImage(named: "Location")!, title: "Location")
    ]
    
    
    // MARK: - View Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getUserDetails { userDetails, status in
            if status == true {
                if let name = userDetails!["accountDetails"] {
                    self.userDetailsArray = name  as! [AnyObject]
                    DispatchQueue.main.async {
                        self.loadingView.stop()
                        self.collectionsView?.reloadData()
                        self.pageControl.numberOfPages = self.userDetailsArray.count
                    }
                }
            }
        }
    }
    
    deinit {
        print("OS reclaiming memory for DashBoardViewcontroller - No Retain Cycles/Leak")
    }
    
    
    func showAlert(){
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        present(alertController,animated:true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
                
        configureCollectionViewUI()
        pageControl.numberOfPages = self.userDetailsArray.count
        configureTabCollectionViewUI()
        
        guard let collectionView = collectionsView  else {
            return
        }
        guard let tabCollectionView = tabCollectionsView  else {
            return
        }
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(tabCollectionView)
        
  
        loadingView.start()
        
        // To test whether the viewcontroller is free from memory leaks
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("someNotificationName"), object: nil, queue: .main) { [weak self] notification  in
//
//            self?.showAlert()
//
//        }

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionsView?.frame = CGRect(x: 0, y: 10, width: view.width, height: view.height * 0.3)
        pageControl.frame = CGRect(x: 0, y: (collectionsView?.bottom ?? view.height * 0.3) , width: view.width, height: 40)
        tabCollectionsView?.frame = CGRect(x: 0, y: pageControl.bottom , width: view.width, height: view.height - view.height * 0.3 - 60)
    }
    
    
    // MARK: - CollectionView UI Setup
    private func configureTabCollectionViewUI() {
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0,
                                                             left: 40,
                                                             bottom: Constants.SectionSpacing,
                                                             right: 40)
        collectionViewFlowLayout.itemSize = DashBoardCollectionViewCell.getSize()
        collectionViewFlowLayout.minimumLineSpacing = Constants.SectionSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = Constants.SectionSpacing
        collectionViewFlowLayout.scrollDirection = .vertical
        
        tabCollectionsView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        
        tabCollectionsView?.delegate = self
        tabCollectionsView?.dataSource = self
        
        tabCollectionsView?.showsVerticalScrollIndicator = false
        tabCollectionsView?.showsHorizontalScrollIndicator = false
        tabCollectionsView?.collectionViewLayout = collectionViewFlowLayout
        //tabCollectionsView?.decelerationRate = UIScrollView.DecelerationRate.normal
        
        tabCollectionsView?.register(DashBoardCollectionViewCell.self, forCellWithReuseIdentifier: DashBoardCollectionViewCell.identifier)
    }
    
    
    private func configureCollectionViewUI() {
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: Constants.SectionSpacing,
                                                             left: Constants.SectionSpacing,
                                                             bottom: Constants.SectionSpacing,
                                                             right: Constants.SectionSpacing)
        collectionViewFlowLayout.itemSize = AccountsListCollectionViewCell.getSize()
        collectionViewFlowLayout.minimumLineSpacing = Constants.SectionSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = Constants.SectionSpacing
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        collectionsView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        
        collectionsView?.delegate = self
        collectionsView?.dataSource = self
        
        collectionsView?.showsVerticalScrollIndicator = false
        collectionsView?.showsHorizontalScrollIndicator = false
        collectionsView?.collectionViewLayout = collectionViewFlowLayout
        collectionsView?.decelerationRate = UIScrollView.DecelerationRate.normal
        //collectionsView?.isPagingEnabled = true
        
        collectionsView?.register(AccountsListCollectionViewCell.self, forCellWithReuseIdentifier: AccountsListCollectionViewCell.identifier)
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let pageWidth = (AccountsListCollectionViewCell.getSize().width
            + Constants.SectionSpacing) * Constants.NumberOfCellsInARow
        currentPage = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth)) + 1
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Immitate pagination for carousel
        let pageWidth = (AccountsListCollectionViewCell.getSize().width
            + Constants.SectionSpacing) * Constants.NumberOfCellsInARow
        let maxPage = Int((scrollView.contentSize.width / pageWidth)) - 1
        var newPage = currentPage
        
        self.pageControl.currentPage = newPage
        
        if velocity.x == 0.0 {
            newPage = Int(floor((targetContentOffset.pointee.x - pageWidth / 2) / pageWidth)) + 1
        } else {
            newPage = velocity.x > 0.0 ? currentPage + 1 : currentPage - 1
            
            // Limit bottom of page is 0
            if newPage < 0 {
                newPage = 0
            }
            
            // Limit top of page
            if newPage > Int((scrollView.contentSize.width / pageWidth)) {
                newPage = Int(ceil((pageWidth + Constants.SectionSpacing) / pageWidth)) - 1
            }
        }
        
        if newPage == maxPage {
            targetContentOffset.pointee.x = scrollView.contentSize.width - UIScreen.main.bounds.size.width
        } else {
            targetContentOffset.pointee.x = CGFloat(newPage) * pageWidth
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionsView!.contentOffset, size: (collectionsView?.bounds.size)!)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionsView?.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
}

extension DashBoardViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return menu.count
        if collectionView == tabCollectionsView {
            return menu.count
        }else {
            return userDetailsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabCollectionsView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashBoardCollectionViewCell.identifier, for: indexPath) as! DashBoardCollectionViewCell
            cell.configure(with: self.menu[indexPath.row].title, imageName: self.menu[indexPath.row].icon)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountsListCollectionViewCell.identifier, for: indexPath) as! AccountsListCollectionViewCell
            cell.configure(with: userDetailsArray[indexPath.row]["customerName"] as! String, accNo: userDetailsArray[indexPath.row]["accountNo"] as! String, avlBal: userDetailsArray[indexPath.row]["availBalanceFcy"] as! String, accType: userDetailsArray[indexPath.row]["accountType"] as! String)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabCollectionsView {
            if indexPath.row == 2 {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TransferVC") as! TransferViewController
                nextViewController.accountDetailsArray = userDetailsArray
                nextViewController.currentAccountId = userDetailsArray[indexPath.row]["accountNo"] as! String
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }else if indexPath.row == 5{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "locationVC") as! LocationViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
        
}
