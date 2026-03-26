//
//  UIImageView+LoadImage.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 23/03/26.
//

import  UIKit

    //MARK: - Movie Images: Allows any img in the app to download and display

extension UIImageView {
    func loadImage(from urlString: String?) {
            //1. create image URL - Convert string to URL object
        guard let urlString, let url = URL(string: urlString) else { image = UIImage(systemName: "photo"); return }
            //2. URL session which brings image from internet server. DataTask sends async req on BG thread
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response , error in
            guard let data, let image = UIImage(data: data) else { print("No Image Fetched"); return }
                //3. Update UI on main thread
            DispatchQueue.main.async {
                self?.image = image
            }
        }
            //4. Start the task (without this req never starts)
        task.resume()
    }
}
