//
//  RandomUtility.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/10/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import Foundation

class RandomUtility {

    static func getDoubleNumberOf(count: Int) -> [Double] {
        var doubleValues: [Double] = []
        for _ in 1 ... count {
            let doubleRandomNumber = Double.random(in: 11000.1...12000.9)
            doubleValues.append(doubleRandomNumber)
        }
        return doubleValues
    }

    static func getDatesOf(count: Int) -> [Double] {
        var doubleValues: [Double] = []
        var initialDateInSeconds = 1588716023 // 5/5/2020

        for _ in 1 ... count {
            doubleValues.append(Double(initialDateInSeconds))
            initialDateInSeconds += 86400 // 86400 is next day
        }
        return doubleValues
    }

    static func update(doubleNumberSeries: [Double], with number: Int) -> [Double] {
        var updatedSeries: [Double] = []
        for doubleNumber in doubleNumberSeries {
            if number > 0 {
                updatedSeries.append(doubleNumber + Double(Int.random(in: 1...number)))
            } else {
                updatedSeries.append(doubleNumber - Double(Int.random(in: 1...abs(number))))
            }
        }
        return updatedSeries
    }

    static func getDatesFor(days: Int) -> [Double] {
        var doubleValues: [Double] = []
        var initialDateInSeconds = 1594944060 // 5/5/2020

        for _ in 1 ... (24 * days) {

            doubleValues.append(Double(initialDateInSeconds))
            initialDateInSeconds += 3600
        }

        return doubleValues
    }

    static func getDrawablePointsFor(days: Int) -> [Double] {
        ///24points in a day
        return getDoubleNumberOf(count: 24 * days)
    }

    static func getExponentialCurveWith(exponent: Double, and capacity: Int) -> [(Double, Double)] {

        var x = 1.0
        var y = 0.0

        let fudgeFactor = 1.1

        var coordinate: [(Double, Double)] = []
        for i in 1 ..< capacity {
            x *= fudgeFactor;
            y = pow(Double(i) + 0.1, exponent)
            coordinate.append((x, y))
        }
        return coordinate
    }


}

extension RandomUtility {

    // MARK:- Get data from CSV

    static func cSVData() -> [[String]]? {
        var dataArray : [[String]]? = [[]]
        if  let path = Bundle.main.path(forResource: "INDU_Daily", ofType: "csv")
        {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let dataEncoded = String(data: data, encoding: .utf8)
                dataArray = dataEncoded?.components(separatedBy: "\r\n").map {
                    $0.components(separatedBy: ",")
                }
//                print("value of data array = \(dataArray ?? [])")
            }
            catch let jsonErr {
                print("\n Error read CSV file: \n ", jsonErr)
                return nil
            }
        }
        return dataArray
    }

    static func getOpenPrice(_ withCount: Int = 247) -> [Double] {
        return getValueOf(count: withCount, for: 1)
    }

    static func getHighPrice(_ withCount: Int = 247) -> [Double] {
        return getValueOf(count: withCount, for: 2)
    }

    static func getLowPrice(_ withCount: Int = 247) -> [Double] {
        return getValueOf(count: withCount, for: 3)
    }

    static func getClosePrice(_ withCount: Int = 247) -> [Double] {
        return getValueOf(count: withCount, for: 4)
    }

    // index values 1 - open, 2 - high, 3 - low, 4 - close
    static func getValueOf(count: Int, for index: Int) -> [Double] {

        var data: [Double] = []

        guard let entireData = cSVData() else {return []}

        for i in 1 ..< count {
            let currentList = entireData[i]
            let value = currentList[index] as String
            data.append(Double(value) ?? 0.0)
        }

        return data
    }

}
