//
//  CommercesViewController.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 28/10/25.
//

import UIKit

protocol CommercesViewProtocol: AnyObject {
    func setCommerces(commerces: [Commerce])
    func reloadCollection()
}

class CommercesViewController: UIViewController {
    
    @IBOutlet weak var commercesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var commerces: [Commerce] = []
    
    var presenter: CommercesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Listado de Comercios"
        
        presenter?.getUserLocation()
        
        presenter?.loadCommerces()
        
        setupCollectionView()
    }
    
    @IBAction func sortByDistance(_ sender: Any) {
        presenter?.sortByDistance(commerces: commerces)
    }
    
    
    private func setupCollectionView() {
        let commerceNib = UINib(nibName: "CommerceCollectionViewCell", bundle: nil)
        commercesCollectionView.register(commerceNib, forCellWithReuseIdentifier: "CommerceCollectionViewCell")
        
        let categoryNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoriesCollectionView.register(categoryNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        
        commercesCollectionView.dataSource = self
        commercesCollectionView.delegate = self
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
    }
}

extension CommercesViewController: CommercesViewProtocol {
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.commercesCollectionView.reloadData()
        }
    }
    
    func setCommerces(commerces: [Commerce]) {
        self.commerces = commerces
    }
}

extension CommercesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == commercesCollectionView {
            return commerces.count
        } else {
            return Category.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == commercesCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommerceCollectionViewCell",
                                                                for: indexPath) as? CommerceCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let item = commerces[indexPath.item]
            cell.nameLabel.text = item.name
            cell.adressLabel.text = item.address?["street"]
            
            switch item.category {
                
            case .beauty:
                cell.categoryImage.image = UIImage(named: "Car wash_white")
                cell.topView.backgroundColor = .green
            case .directSales:
                cell.categoryImage.image = UIImage(named: "Truck_white")
                cell.topView.backgroundColor = .cyan
            case .electricStation:
                cell.categoryImage.image = UIImage(named: "Electric Scooter_white")
                cell.topView.backgroundColor = .red
            case .food:
                cell.categoryImage.image = UIImage(named: "Catering_white")
                cell.topView.backgroundColor = .yellow
            case .gasStation:
                cell.categoryImage.image = UIImage(named: "EES_white")
                cell.topView.backgroundColor = .orange
            case .leisure:
                cell.categoryImage.image = UIImage(named: "Leisure_white")
                cell.topView.backgroundColor = .blue
            case .shopping:
                cell.categoryImage.image = UIImage(named: "Cart_white")
                cell.topView.backgroundColor = .systemPink
            case .none:
                cell.categoryImage.image = UIImage(named: "placeholder")
                cell.topView.backgroundColor = .gray
            }
            
            if let location = item.location {
                cell.distanceLabel.text = presenter?.calculateUserDistance(commerceLocation: location)
            } else {
                cell.distanceLabel.text = ""
            }
            
            return cell
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell",
                                                                for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let item = Category.allCases[indexPath.item]
            cell.categoryNameLabel.text = item.rawValue
            
            switch item {
                
            case .beauty:
                cell.categoryNameLabel.textColor = .green
            case .directSales:
                cell.categoryNameLabel.textColor = .cyan
            case .electricStation:
                cell.categoryNameLabel.textColor = .red
            case .food:
                cell.categoryNameLabel.textColor = .yellow
            case .gasStation:
                cell.categoryNameLabel.textColor = .orange
            case .leisure:
                cell.categoryNameLabel.textColor = .blue
            case .shopping:
                cell.categoryNameLabel.textColor = .systemPink
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == commercesCollectionView {
            guard let navCon = self.navigationController else { return }
            presenter?.openCommerceDetail(commerce: commerces[indexPath.item], navController: navCon)
            
        } else {
            let categorySelected = Category.allCases[indexPath.item]
            presenter?.filterCommerces(category: categorySelected)
        }
    }
}

extension CommercesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == commercesCollectionView {
            let width = collectionView.bounds.width - (16*2)
            let height: CGFloat = 140
            return CGSize(width: width, height: height)
        } else {
            return CGSize(width: 150, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}


