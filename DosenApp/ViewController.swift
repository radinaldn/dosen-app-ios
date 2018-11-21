//
//  ViewController.swift
//  DosenApp
//
//  Created by Aldresti on 05/11/18.
//  Copyright © 2018 TopApp. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation

class ViewController: UIViewController,WKNavigationDelegate {
    
    var webView: WKWebView!
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    override func loadView() {
        webView = WKWebView();
        webView.navigationDelegate = self;
        view = webView;
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.delegate = self
        startLocation = nil
        
        // 1
        let url = URL(string: "https://topapp.id/smart-presence/web")!
        webView.load(URLRequest(url: url))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    @IBAction func startWhenInUse(_sender: Any){
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func starAlways(_sender: Any){
        locationManager.stopUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func resetDistance(_sender: Any){
        startLocation = nil
    }
    
    func locationManager(_manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]){
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        print(latestLocation.coordinate.latitude)
        print(latestLocation.coordinate.longitude)
        print(latestLocation.altitude)
        
        
        if (startLocation == nil){
            startLocation = latestLocation
        }
        
        let distanceBetween: CLLocationDistance =
        latestLocation.distance(from: startLocation)
        
        print(distanceBetween)
    }
    
    func locationManager(_manager: CLLocationManager,
                         didFailWithError error: Error){
        print(error.localizedDescription)
    }

}

