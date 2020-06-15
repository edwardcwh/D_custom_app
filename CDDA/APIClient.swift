//
//  APIClient.swift
//  CDDA
//
//  Created by edwardchong on 24/5/20.
//  Copyright © 2020 edwardchong. All rights reserved.
//

import Foundation

typealias MovieJSON  = [String: Any]

struct APIClient {

    static func getMoviesAPI(completion: @escaping (MovieJSON?) -> Void){
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=9b34b429b4f1da029089a53cef55bbb2&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
        let session = URLSession.shared
        guard let unwrappedURL = url else {print("Error unwrapping URL"); return }
        let dataTask = session.dataTask(with: unwrappedURL) { (data,response, error) in
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? MovieJSON
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
