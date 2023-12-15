//
//  Service.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 14.12.23.
//

import UIKit

final class Service {
    static func stringToImage(str: String) -> UIImage? {
       let stringUrl = "https:" + str
        guard let url = URL(string: stringUrl),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}


