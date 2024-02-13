//
//  Weather.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}
// MARK: - Current
struct Current: Codable {
    let lastUpdatedEpoch: Double
    let lastUpdated: String
    let tempC: Float
    let tempF: Float
    let isDay: Float
    let condition: CurrentCondition

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
    }
}
// MARK: - CurrentCondition
struct CurrentCondition: Codable {
    let text, icon: String
}
// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}
// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let day: Day
    let astro: Astro
    let hour: [Hour]
}
// MARK: - Astro
struct Astro: Codable {
}
// MARK: - Day
struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Float
    let avgtempC, avgtempF: Float
    let totalsnowCM: Float?
    let condition: DayCondition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case totalsnowCM = "totalsnow_cm"
        case condition
    }
}
// MARK: - DayCondition
struct DayCondition: Codable {
    let text, icon: String
    let code: Float
}
// MARK: - Hour
struct Hour: Codable {
    let time: String
    let tempC, tempF: Float
    let isDay: Float
    let condition: CurrentCondition

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
    }
}
// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Float
    let tzID: String
    let localtimeEpoch: Float
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
