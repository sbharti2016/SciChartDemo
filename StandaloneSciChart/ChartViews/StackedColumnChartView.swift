//
//  BarChartView.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/25/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import SciChart

struct ColumnSeriesData {

}


class StackedColumnChartView: UIView {

    static func chart() -> SCIChartSurface {
        let surface: SCIChartSurface = SCIChartSurface()
        update(surface)
        return surface
    }

    static func update(_ surface: SCIChartSurface) {
        let xAxis = SCINumericAxis()
        xAxis.autoRange = .once

        let yAxis = SCINumericAxis()
        yAxis.autoRange = .always

        let inSeries = [10, 12, 14, 16, 19]
        let nzSeries = [11, 13, 15, 17, 19]
        let cnSeries = [8, 12, 16, 10, 19]
        let zbSeries = [28, 10, 16, 8, 19]

        let columnCollection = SCIHorizontallyStackedColumnsCollection()

        var seriesList: [SCIXyDataSeries] = []

        for index in 0 ..< inSeries.count {

            let dataSeries = SCIXyDataSeries(xType: .double, yType: .double)

            dataSeries.append(x: 0, y: inSeries[index])
            dataSeries.append(x: 1, y: nzSeries[index])
            dataSeries.append(x: 2, y: cnSeries[index])
            dataSeries.append(x: 3, y: zbSeries[index])

            dataSeries.seriesName = "\(index)"

            seriesList.append(dataSeries)

        }

        for index in 0 ..< seriesList.count {
            columnCollection.add(getRenderableSeriesWith(dataSeries: seriesList[index], fillColor:0xff3399ff, strokeColor:0xff2D68BC))
        }

        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(xAxis)
            surface.yAxes.add(yAxis)
            surface.renderableSeries.add(columnCollection)
            surface.chartModifiers.add(createDefaultModifiers())
        }
    }

    static func createDefaultModifiers() -> SCIModifierGroup {

        let zoomPan: SCIZoomPanModifier = SCIZoomPanModifier()
        zoomPan.receiveHandledEvents = true
        let pinchZoomModifier = SCIPinchZoomModifier()

        let extendZoomModifier = SCIZoomExtentsModifier()

        let xAxisDragmodifier = SCIXAxisDragModifier()
        let yAxisDragmodifier = SCIYAxisDragModifier()

        let rolloverModifier = SCIRolloverModifier()
        rolloverModifier.showTooltip = true

        let modifierGroup: SCIModifierGroup = SCIModifierGroup()
        modifierGroup.childModifiers.add(items: xAxisDragmodifier, yAxisDragmodifier, pinchZoomModifier, extendZoomModifier, rolloverModifier)
        return modifierGroup
    }

    static func getRenderableSeriesWith(dataSeries: SCIXyDataSeries, fillColor: uint, strokeColor: uint) -> SCIStackedColumnRenderableSeries {
           let rSeries = SCIStackedColumnRenderableSeries()
           rSeries.dataSeries = dataSeries
//           rSeries.fillBrushStyle = SCISolidBrushStyle(colorCode: fillColor)
           rSeries.strokeStyle = SCISolidPenStyle(colorCode: strokeColor, thickness: 1)
           return rSeries
       }

}

