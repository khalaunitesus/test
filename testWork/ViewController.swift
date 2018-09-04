//
//  ViewController.swift
//  testWork
//
//  Created by yakuza on 04/09/2018.
//  Copyright © 2018 yakuza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stockStructure: StockStructure!
    var timer: Timer?
    
    @IBAction func refreshButton(_ sender: Any) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        
        loadData()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 15.0,
                                     target: self,
                                     selector: #selector(eventWith(timer:)),
                                     userInfo: loadData(),
                                     repeats: true)
    }
    
    @objc func eventWith(timer: Timer!) {
        let info = timer.userInfo as Any
        print(info)
        print("Refresh every 15 sec")
    }
    
    func loadData(){
        let url = "http://phisix-api3.appspot.com/stocks.json"
        let json = try! String(contentsOf: URL(string: url)!)
        
        stockStructure = try! StockStructure(json)
        self.tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if stockStructure != nil {
            let countRows = stockStructure.stock.count
            return countRows
        }else{
            let countRows = 0
            return countRows
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell
        
        let stock = stockStructure.stock[indexPath.row]
        
        // Down cast
        let volumeFromStock = stock.volume as NSNumber
        let volumeToString: String = volumeFromStock.stringValue
        
        let amountFromStock = stock.price.amount
        let amountToString = String(format: "%.2f", amountFromStock)
        
        //return cell 
        cell.nameLbl!.text = stock.name
        cell.volumeLbl!.text = volumeToString
        cell.amountLbl!.text = amountToString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
    
    
    
}

