//
//  SplineMountainChart.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/17/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import SciChart

class SplineMountainChart {

    static func chart() -> SCIChartSurface {
        let surface: SCIChartSurface = SCIChartSurface()
        update(surface)
        return surface
    }

    static func update(_ surface: SCIChartSurface) {
        let xBottomAxis = SCINumericAxis()
        xBottomAxis.growBy = SCIDoubleRange(min: 0.0, max: 0.1)

        let yRightAxis = SCINumericAxis()
        yRightAxis.growBy = SCIDoubleRange(min: 0.0, max: 0.1)

        let coordinates = RandomUtility.getExponentialCurveWith(exponent: 1.8, and: 50)

        let dataSeries = SCIXyDataSeries(xType: .double, yType: .double)

        var xValues: [Double] = [], yValues: [Double] = []
        for index in 0 ..< coordinates.count {
            xValues.append(coordinates[index].0)
            yValues.append(coordinates[index].1)
        }
        dataSeries.append(x: 0.0, y: 0.0)
        dataSeries.append(x: xValues, y: yValues)

        let rSeries = SCISplineMountainRenderableSeries()
        rSeries.dataSeries = dataSeries
        //        rSeries.pointMarker = EllipsePointMarker(size: 7, strokeStyle: SCISolidPenStyle(colorCode: 0xFF006400, thickness: 1.0), fillStyle: SCISolidBrushStyle(colorCode: 0xFFFFFFFF))
        rSeries.strokeStyle = SCISolidPenStyle(colorCode: 0xAAFFC9A8, thickness: 1.0, strokeDashArray: nil, antiAliasing: true)
        rSeries.areaStyle = SCILinearGradientBrushStyle(startColorCode: 0xAAFF8D42, endColorCode: 0x88090E11)

        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(xBottomAxis)
            surface.yAxes.add(yRightAxis)
            surface.renderableSeries.add(items: rSeries)
            surface.chartModifiers.add(self.createDefaultModifiers())

            SCIAnimations.wave(rSeries, duration: 3.0, andEasingFunction: SCICubicEase())
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

