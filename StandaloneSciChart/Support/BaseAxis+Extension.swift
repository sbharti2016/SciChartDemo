//
//  BaseAxis+Extension.swift
//  PortfolioScene
//
//  Created by Sanjeev Bharti on 7/20/20.
//

import Foundation
import SciChart

extension SCIAxisBase {

    @objc func hideBackground() {
        drawMajorBands = false
        drawMinorTicks = false
        drawMajorTicks = false
        drawMajorGridLines = false
        drawMinorGridLines = false
    }

    @objc func drawGridLineFor(majorBands: Bool = false,
                               majorTicks: Bool = false,
                               minorTicks: Bool = false,
                               majorGridLines: Bool = false,
                               minorGridLines: Bool = false) {

        drawMajorBands = majorBands
        drawMajorTicks = majorTicks
        drawMinorTicks = minorTicks
        drawMajorGridLines = majorGridLines
        drawMinorGridLines = minorGridLines

    }

}
