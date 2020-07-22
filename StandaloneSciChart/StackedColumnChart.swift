//
//  BarChartView.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/25/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import SciChart

class StackedColumnChartView: UIView {

    static func chart() -> SCIChartSurface {
        let surface: SCIChartSurface = SCIChartSurface()
        update(surface)
        return surface
    }

    static func update(_ surface: SCIChartSurface) {
        let xAxis = SCINumericAxis()
        let yAxis = SCINumericAxis()
        let dataSeries = SCIXyDataSeries(xType: .int, yType: .int)
        let yValues = [50, 35, 61, 58, 50, 50, 40, 53, 55, 23, 45, 12, 59, 60]
        for i in 0 ..< yValues.count {
            dataSeries.append(x: i, y: yValues[i])
        }

        let rSeries = SCIFastColumnRenderableSeries()
        rSeries.fillBrushStyle = SCISolidBrushStyle(colorCode: 0xff3cf3a6)
        rSeries.dataSeries = dataSeries

        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(xAxis)
            surface.yAxes.add(yAxis)
            surface.renderableSeries.add(rSeries)
            surface.chartModifiers.add(createDefaultModifiers())

            SCIAnimations.scale(rSeries, duration: 3.0, andEasingFunction: SCIElasticEase())
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
        //        rolloverModifier.modifierName = "rolloverModifierName"
        rolloverModifier.showTooltip = true

        let legend = SCILegendModifier()
        legend.showCheckBoxes = true

        //        let toolTipModifier = SCITooltipModifier()

        let modifierGroup: SCIModifierGroup = SCIModifierGroup()
        modifierGroup.childModifiers.add(items: xAxisDragmodifier, yAxisDragmodifier, pinchZoomModifier, extendZoomModifier, legend, rolloverModifier)
        return modifierGroup
    }

}

