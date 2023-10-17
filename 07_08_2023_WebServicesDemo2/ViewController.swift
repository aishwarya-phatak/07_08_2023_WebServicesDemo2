//
//  ViewController.swift
//  07_08_2023_WebServicesDemo2
//
//  Created by Vishal Jagtap on 16/10/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var productsTableview: UITableView!
    private let productTableViewCellReuseIdentifier = "ProductTableViewCell"
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        registerXIBWithTableview()
        parseJSON()
    }
    
    func initializeTableView(){
        productsTableview.dataSource = self
        productsTableview.delegate = self
    }
    
    func registerXIBWithTableview(){
        let uiNib = UINib(nibName: productTableViewCellReuseIdentifier, bundle: nil)
        self.productsTableview.register(uiNib, forCellReuseIdentifier: productTableViewCellReuseIdentifier)
    }
    
    func parseJSON(){
        let url = URL(string: "https://dummyjson.com/products")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let extractedData = data else { return }
            guard let extractedResponse = response else { return }
            
            print(response)
            
            let jsonResponse = try! JSONSerialization.jsonObject(with: extractedData) as! [String : Any]
            
            let productsResponse = jsonResponse["products"] as! [[String : Any]]
            let total = jsonResponse["total"] as! Int
            let skip = jsonResponse["skip"] as! Int
            let limit = jsonResponse["limit"] as! Int
            
            for eachProductFromResponse in productsResponse{
                
                let eachProductId = eachProductFromResponse["id"] as! Int
                let eachProductTitle = eachProductFromResponse["title"] as! String
                let imageUrls = eachProductFromResponse["images"] as! [String]
                
//                for eachImagUrlString in imageUrls{
//                 let eachImageUrl = URL(string: eachImagUrlString)
//                }
                
                let newProductObject = Product(
                    id: eachProductId,
                    title: eachProductTitle,
                    images: imageUrls)
                
                self.products.append(newProductObject)
            }
            
            DispatchQueue.main.async {
                self.productsTableview.reloadData()
            }
        }
        dataTask.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productTableViewCell = self.productsTableview.dequeueReusableCell(withIdentifier: productTableViewCellReuseIdentifier, for: indexPath) as! ProductTableViewCell
        
        productTableViewCell.productIdLabel.text = products[indexPath.row].id.codingKey.stringValue
        productTableViewCell.productTitleLabel.text = products[indexPath.row].title
        
        for eachImageURLString  in products[indexPath.row].images {
            let eachProductUrl = URL(string: eachImageURLString)
            productTableViewCell.productImageView.kf.setImage(with: eachProductUrl)
        }
        return productTableViewCell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
}
