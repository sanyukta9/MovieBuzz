//
//  MovieManager.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//
// Single reusable class for all API calls [Singleton Pattern]
//[weak self] -> prevents memory leak if cell is reused

import Foundation
import UIKit

//MARK: - Movie Data

class MovieManager {
    static let shared = MovieManager()
    private init() {} //single instance only
    
    func fetchData<T: Codable> (_ type: T.Type, urlString: String, completion: @escaping (T?) -> Void){

        //1. create URL - Convert string to URL object
        guard let url = URL(string: urlString) else { print("Invalid URL"); completion(nil); return }
        //2. URL session which brings data from internet server. DataTask sends async req on BG thread
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data, error == nil else { print("No Data Received"); completion(nil); return }
        //3. Parse the JSON data into swift objects - decoding
            let parsedData = try? JSONDecoder().decode(T.self, from: data)
            completion(parsedData)
        }
        //4. Start the task (without this req never starts)
        task.resume()
    }
    
}

//MARK: - Movie Images

extension UIImageView {
    func loadImage(from urlString: String?) {
        //1. create image URL - Convert string to URL object
        guard let urlString, let url = URL(string: urlString) else { image = UIImage(systemName: "photo"); return }
        //2. URL session which brings image from internet server. DataTask sends async req on BG thread
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response , error in
            guard let data, let image = UIImage(data: data) else { return }
        //3. Update UI on main thread
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        //4. Start the task (without this req never starts)
        task.resume()
    }
}
