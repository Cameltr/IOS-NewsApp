//
//  UIImageViewExtension.swift
//  S1102
//
//  Created by mac on 2021/4/29.
//

import UIKit

extension UIImageView{
    func downloadAsyncFrom(url:String){
        let urlNet = URL(string: url)
        let task = URLSession.shared.dataTask(with: urlNet!){
            (data,responds,error) in
            if let nsd = data{
                DispatchQueue.main.async {
                    self.image = UIImage(data: nsd, scale: 1)
                    self.contentMode = .scaleAspectFit
                }
            }
        }
        task.resume()
    }
}
