//
//  MovieManager.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//
import Foundation

class MovieManager {
    func fetchMovies(urlString: String, completion: @escaping ([Results]?) -> Void){
        let urlString = urlString
        
        //1. create URL - Convert string to URL object
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        //2. create a URL session
        let session = URLSession(configuration: .default)
        
        //3. assign a data task to session - ASYNC
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let safeData = data, error == nil else { print("No Data Received"); return }
        //4. Parse the JSON data into swift objects
            if let parsedMovies = self.parseJSONData(safeData){
                print("Successfully fetched \(parsedMovies.count) movies from: \(urlString)")
                completion(parsedMovies)
            }
            else{
                completion(nil)
            }
        }
        //5. Start the task (without this req never starts)
        task.resume()
    }
    
    //MARK: - 4
    func parseJSONData(_ movieData: Data) -> [Results]?{
        do {
            let decodedData = try JSONDecoder().decode(TMDBResponse.self, from: movieData)
            
            print("page: \(decodedData.page)")
            print("total_pages: \(decodedData.total_pages)")
            print("total_results: \(decodedData.total_results)")
            if let first = decodedData.results.first {
                print("first.id: \(first.id)")
                print("first.title: \(first.title)")
                print("first.overview: \(first.overview)")
                print("first.posterURL: \(first.posterURL!)")
                print("first.poster_path: \(first.poster_path!)")
                print("first.releaseDate: \(first.release_date)")
                print("first.similarURL: \(first.similarURL)")
            }
            return decodedData.results
        }
        catch {
            print("Failed to parse JSON: \(error)")
            return nil
        }
    }
    
}
