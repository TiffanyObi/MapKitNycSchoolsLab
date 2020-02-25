//
//  NycSchoolAPIClient.swift
//  MapKitNycSchoolsLab
//
//  Created by Tiffany Obi on 2/25/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation
import NetworkHelper

struct NycSchoolsAPIClient {
    
    static func getListOfSchools(completion: @escaping (Result<[NYCSchools], AppError>) -> ()) {
        
        let endpointURLString = "https://data.cityofnewyork.us/resource/uq7m-95z8.json"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                
                do {
                    let schools = try JSONDecoder().decode([NYCSchools].self, from: data)
                    completion(.success(schools))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                    
                }
            }
        }
    }
}
