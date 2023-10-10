//
//  WeatherManager.swift
//  My Weather App
//
//  Created by Clem OJ on 28/09/2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    private let apiKey = "ecf9ac563fe7b409a7999af3dbd25ccb"
    
    func getWeatherData( for cordinates: CLLocationCoordinate2D, completion: @escaping (Result<WeatherResponse, WeatherError>) -> Void ){
        
        //if url is incorrect, escape the function with invalid URL error
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(cordinates.latitude)&lon=\(cordinates.longitude)&appid=\(apiKey)&units=metric") else {
            completion(.failure(WeatherError.invalidURL))
            return
        }
        
        //if url is correct, fetch the data
        URLSession.shared.dataTask(with: url) { data , response, error in
            //if there's no data and theres error, escape the function with invalid data error
            guard let data = data , error == nil else {
                completion(.failure(WeatherError.invalidData))
                return
            }
            
            //if the data is available escape with the response and decode the json to weather struct
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            }
            catch {
                //if theres a problem with decoding the data, escape the function with data error
                completion(.failure(WeatherError.invalidDataDecoding))
            }
        }.resume()
    }
    
    
    func getWeatherData(for city: String, completion: @escaping (Result<WeatherResponse, WeatherError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(WeatherError.invalidData))
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }.resume()
    }
}

enum WeatherError: Error {
    case invalidURL
    case invalidData
    case invalidDataDecoding
}

struct WeatherResponse: Decodable {
    //declare the response variables
    var weather: [WeatherDetails]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var sys: Country
    
    //declare the data structure
    struct WeatherDetails: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
    }
    
    struct Country: Decodable {
        var country: String
    }
    
    var conditionName: String {
        guard let firstWeather = weather.first else {
            return "cloud"
        }
        
        switch firstWeather.id{
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }
}

extension WeatherResponse.MainResponse {
    var tempMin: Double {
        return temp_min
    }
    var tempMax: Double {
        return temp_max
    }
}
