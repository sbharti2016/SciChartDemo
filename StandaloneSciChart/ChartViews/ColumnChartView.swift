//
//  BarChartView.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/25/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import SciChart

class ColumnsTripleColorPalette : SCIPaletteProviderBase<SCIFastColumnRenderableSeries>, ISCIFillPaletteProvider {

    let colors = SCIUnsignedIntegerValues()
    let desiredColors:[UInt32] = [0xff40BB80, 0xff40BB80, 0xffBF2E53]

    init() {
        super.init(renderableSeriesType: SCIFastColumnRenderableSeries.self)
    }

    override func update() {
        let count = renderableSeries!.currentRenderPassData.pointsCount
        colors.count = count

        for i in 0 ..< count {
            colors.set(desiredColors[i % 3], at: i)
        }
    }

    var fillColors: SCIUnsignedIntegerValues! { return colors }
}


class ColumnChartView: UIView {

    static func chart() -> SCIChartSurface {
        let surface: SCIChartSurface = SCIChartSurface()
        update(surface)
        return surface
    }

    static func update(_ surface: SCIChartSurface) {
        let xAxis = SCINumericAxis()
        xAxis.growBy = SCIDoubleRange(min: 0.0, max: 0.1)

        let yAxis = SCINumericAxis()
        yAxis.growBy = SCIDoubleRange(min: 1.0, max: 1.0)

        let dataSeries = SCIXyDataSeries(xType: .int, yType: .int)
        let yValues = [50, 35, 61, 58, 50, 50, 40, 53, 55, 23, 45, 12, 59, 60]
        for i in 0 ..< yValues.count {
            dataSeries.append(x: i, y: yValues[i])
        }

        let rSeries = SCIFastColumnRenderableSeries()
        rSeries.fillBrushStyle = SCISolidBrushStyle(colorCode: 0xff3cf3a6)
        rSeries.dataSeries = dataSeries
        rSeries.paletteProvider = ColumnsTripleColorPalette()

        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(xAxis)
            surface.yAxes.add(yAxis)
            surface.renderableSeries.add(rSeries)
            surface.chartModifiers.add(createDefaultModifiers())
        }
    }

    static func createDefaultModifiers() -> SCIModifierGroup {

        let zoomPan: SCIZoomPanModifier = SCIZoomPanModifier()
        zoomPan.receiveHandledEvents = true
        let pinchZoomModifier = SCIPinchZoomModifier()
        pinchZoomModifier.isUniformZoom = true

        let extendZoomModifier = SCIZoomExtentsModifier()

        let xAxisDragmodifier = SCIXAxisDragModifier()
        let yAxisDragmodifier = SCIYAxisDragModifier()

        let rolloverModifier = SCIRolloverModifier()
        rolloverModifier.showTooltip = true

        let legend = SCILegendModifier()
        legend.showCheckBoxes = true

        let modifierGroup: SCIModifierGroup = SCIModifierGroup()
        modifierGroup.childModifiers.add(items: xAxisDragmodifier, yAxisDragmodifier, pinchZoomModifier, extendZoomModifier, legend, rolloverModifier)
        return modifierGroup
    }

}

