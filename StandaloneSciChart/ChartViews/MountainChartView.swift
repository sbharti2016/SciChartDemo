//
//  MountainChartView.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/8/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import SciChart

class MountainChartView: UIView {

    static func chart() -> SCIChartSurface {
        let surface: SCIChartSurface = SCIChartSurface()
        update(surface)
        return surface
    }

    static func update(_ surface: SCIChartSurface) {

        // plotting 50 points on chart

        let pointCount:Int = 50

        let priceValues: [Double] = RandomUtility.getDoubleNumberOf(count: pointCount)
        let dateValues: [Double] = RandomUtility.getDatesOf(count: pointCount)

        let priceData: SCIDoubleValues = SCIDoubleValues(values: priceValues)
        let dateList: SCIDateValues = SCIDateValues(values: dateValues)

        let xAxis = SCIDateAxis()

        // hides x-axis completely
        xAxis.isVisible = false

        xAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)

        let yAxis = SCINumericAxis()

        // hides y-axis completely
        yAxis.isVisible = false

        yAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)

        let dataSeries = SCIXyDataSeries(xType: .date, yType: .double)
        dataSeries.append(x: dateList, y: priceData)

        let rSeries = SCIFastMountainRenderableSeries()

        // Change the rendering of the r-series to digital mode
        // rSeries.isDigitalLine = false

        rSeries.dataSeries = dataSeries
        rSeries.zeroLineY = 10000

        // Controls the background under graph
        //0x00000055 - clear color, 0x00000055 - Brown color
        rSeries.areaStyle = SCILinearGradientBrushStyle(start: CGPoint(x: 0.0, y: 0.2), end: CGPoint(x: 0.0, y: 1.0), startColorCode:0x00000055 , endColorCode: 0x00000055)
        rSeries.strokeStyle = SCISolidPenStyle(colorCode: 0xAAFFC9A8, thickness: 3.0)

        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(xAxis)
            surface.yAxes.add(yAxis)
            surface.renderableSeries.add(rSeries)
            surface.chartModifiers.add(self.createDefaultModifiers())
            SCIAnimations.sweep(rSeries, duration: 3.0, easingFunction: SCICubicEase())
        }
    }

    static func createDefaultModifiers() -> SCIModifierGroup {
        let zoomPan: SCIZoomPanModifier = SCIZoomPanModifier()
        zoomPan.receiveHandledEvents = true
        let pinchZoomModifier = SCIPinchZoomModifier()
        let modifierGroup: SCIModifierGroup = SCIModifierGroup()
        modifierGroup.childModifiers.add(items: zoomPan, pinchZoomModifier)

        return modifierGroup
    }

}
