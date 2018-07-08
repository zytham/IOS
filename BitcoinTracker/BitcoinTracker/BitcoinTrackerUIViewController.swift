//
//  BitcoinTrackerUIViewController.swift
//  BitcoinTracker
//
//  Created by Nikhil Ranjan on 08/07/18.
//  Copyright © 2018 Devinline. All rights reserved.
//

import UIKit

class BitcoinTrackerUIViewController: UIViewController {
    
    @IBOutlet weak var dollarBitcoin: UILabel!
    @IBOutlet weak var euroBitcoin: UILabel!
    @IBOutlet weak var yenBitcoin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*First load last updated price */
        getDefaultPrice()
        /*Call API to get latest bitcoin value*/
        getPrice()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Get stale old data - last time updated ("^" indicate stale/old date shown)
    func getDefaultPrice(){
        let usdPrice = UserDefaults.standard.double(forKey: "USD")
        if usdPrice != 0.0 {
            self.dollarBitcoin.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD") + "^"
        }
        let yenPrice = UserDefaults.standard.double(forKey: "YEN")
        if yenPrice != 0.0 {
            self.yenBitcoin.text = self.doubleToMoneyString(price: yenPrice, currencyCode: "YEN") + "^"
        }
        let euroPrice = UserDefaults.standard.double(forKey: "EUR")
        if euroPrice != 0.0 {
            self.euroBitcoin.text = self.doubleToMoneyString(price: euroPrice, currencyCode: "EUR") + "^"
        }
    }
    func getPrice(){
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            URLSession.shared.dataTask(with: url){(data, respnse, error) in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Double] {
                        if let jsonDict = json {
                            DispatchQueue.main.async {
                                /*if let usdPrice = jsonDict["USD"]{
                                    self.dollarBitcoin.text = "$ \(usdPrice)"
                                }
                                if let pndPrice = jsonDict["PND"]{
                                    self.yenBitcoin.text = "￡ \(pndPrice)"
                                }
                                if let euroPrice = jsonDict["EUR"]{
                                    self.euroBitcoin.text = "€ \(euroPrice)"
                                }*/
                                if let usdPrice = jsonDict["USD"]{
                                    self.dollarBitcoin.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD")
                                UserDefaults.standard.set(usdPrice, forKey: "USD")
                                }
                                if let yenPrice = jsonDict["JPY"]{
                                    self.yenBitcoin.text = self.doubleToMoneyString(price: yenPrice, currencyCode: "JPY")
                                     UserDefaults.standard.set(yenPrice, forKey: "JPY")
                                }
                                if let euroPrice = jsonDict["EUR"]{
                                    self.euroBitcoin.text = self.doubleToMoneyString(price: euroPrice, currencyCode: "EUR")
                                     UserDefaults.standard.set(euroPrice, forKey: "EUR")
                                }
                                // To update defaults dict with updated values
                                UserDefaults.standard.synchronize()
                            }
                        }
                    }
                }else{
                     print("It did not worked.")
                }
            }.resume()
        }
    }
    /*Format currenncy unit and value */
    func doubleToMoneyString(price: Double, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.currencyCode = currencyCode
        formatter.numberStyle = .currency
        let priceString = formatter.string(from: NSNumber(floatLiteral: price))
        if priceString == nil{
            return "Error"
        }else{
            return priceString!
        }
    }

    @IBAction func refreshCurrValue(_ sender: Any) {
        self.getPrice()
    }
}
