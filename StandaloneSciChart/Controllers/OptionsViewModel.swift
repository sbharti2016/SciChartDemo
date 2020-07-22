//
//  OptionsViewModel.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/10/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import Foundation
import SciChart

class OptionsViewModel {

    var currentlySelectedChartType: ChartType = .mountain

    enum ChartType: CaseIterable {
        case mountain
        case splineMountain
        case candle
        case column
        case stackedColumn
    }

    func selectChart(type: ChartType) {
        switch type {
        case .mountain:
            currentlySelectedChartSurface = MountainChartView.chart()
        case .splineMountain:
            currentlySelectedChartSurface = SplineMountainChart.chart()
        case .candle:
            currentlySelectedChartSurface = CandlestickChartView.chart()
        case .column:
            currentlySelectedChartSurface = ColumnChartView.chart()
        case .stackedColumn:
            currentlySelectedChartSurface = StackedColumnChartView.chart()
        }
        currentlySelectedChartType = type
    }

    var currentlySelectedChartSurface: SCIChartSurface?
}
