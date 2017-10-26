//
//  ViewController.swift
//  008-find-my-position
//
//  Created by  moma on 2017/10/19.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationStrLabel: UILabel!
    @IBOutlet weak var findButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 磨玻璃
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.frame
        self.view.addSubview(blurView)
        
        // 前景内容
        blurView.contentView.addSubview(locationLabel)
        blurView.contentView.addSubview(locationStrLabel)
        blurView.contentView.addSubview(findButton)
        
        locationManager.delegate = self
    }
    
    @IBAction func findMyLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            let locationText = "纬度 Latitude:\(currentLocation.coordinate.latitude)\n经度 Longitude:\(currentLocation.coordinate.longitude)"
            locationLabel.text = locationText
            reverseGeocode(location: currentLocation)
            locationManager.stopUpdatingLocation()
        }
    }
    
    // 地理信息反编码
    func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            // 强制转成简体中文
            // let array = NSArray(object: "zh-hans")
            // UserDefaults.standard.set(array, forKey: "AppleLanguages")
            // 显示所有信息
            if let error = error {
                print("错误：\(error.localizedDescription))")
                self.locationStrLabel.text = "错误：\(error.localizedDescription))"
                return
            }
            
            if let p = placemarks?[0] {
                // print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                
                self.locationStrLabel.text = address
            } else {
                print("No placemarks!")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

