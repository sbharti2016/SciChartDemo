//
//  CandlestickChartView.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/7/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import SciChart
import SciChart.Protected.SCIFastCandlestickRenderableSeries


class CandlestickChartView: UIView {

    static func chart() -> SCIChartSurface {
        let surface: SCIChartSurface = SCIChartSurface()
        update(surface)
        return surface
    }

    static func update(_ surface: SCIChartSurface) {

        let seriesSize = 247
        let xAxis = SCICategoryDateAxis()
        xAxis.growBy = SCIDoubleRange(min: 0.0, max: 0.1)
        xAxis.visibleRange = SCIDoubleRange(min: -1.0, max: 20)

        let yAxis = SCINumericAxis()
        yAxis.growBy = SCIDoubleRange(min: 1.0, max: 1.0)

        let dataSeries = SCIOhlcDataSeries(xType: .date, yType: .double)
        let dateData = SCIDateValues(values: RandomUtility.getDatesOf(count: seriesSize))

        let openPriceData = SCIDoubleValues(values: RandomUtility.getOpenPrice())
        let highPriceData = SCIDoubleValues(values: RandomUtility.getHighPrice())
        let lowPriceData = SCIDoubleValues(values: RandomUtility.getLowPrice())
        let closePriceData = SCIDoubleValues(values: RandomUtility.getClosePrice())

        dataSeries.append(x: dateData,
                          open: openPriceData,
                          high: highPriceData,
                          low: lowPriceData,
                          close: closePriceData)

        let columnSeries = SCIFastColumnRenderableSeries()
        columnSeries.fillBrushStyle = SCISolidBrushStyle(colorCode: 0xff3cf3a6)
        columnSeries.dataSeries = dataSeries

        let rSeries = SCIFastCandlestickRenderableSeries()
        rSeries.dataSeries = dataSeries
        rSeries.strokeUpStyle = SCISolidPenStyle(colorCode: 0xFF00AA00, thickness: 1.0)
        rSeries.fillUpBrushStyle = SCISolidBrushStyle(colorCode: 0x9000AA00)
        rSeries.strokeDownStyle = SCISolidPenStyle(colorCode: 0xFFFF0000, thickness: 1.0)
        rSeries.fillDownBrushStyle = SCISolidBrushStyle(colorCode: 0x90FF0000)

        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(xAxis)
            surface.yAxes.add(yAxis)
            surface.renderableSeries.add(items: rSeries)
            surface.chartModifiers.add(createDefaultModifiers())
            SCIAnimations.wave(rSeries, duration: 3.0, andEasingFunction: SCICubicEase())
        }
    }

    static func createDefaultModifiers() -> SCIModifierGroup {

        let zoomPan: SCIZoomPanModifier = SCIZoomPanModifier()
        zoomPan.receiveHandledEvents = true
        let pinchZoomModifier = SCIPinchZoomModifier()

        let extendZoomModifier = SCIZoomExtentsModifier()

        let rolloverModifier = SCIRolloverModifier()
        rolloverModifier.showTooltip = true

        let legend = SCILegendModifier()
        legend.showCheckBoxes = true

        let modifierGroup: SCIModifierGroup = SCIModifierGroup()
        modifierGroup.childModifiers.add(items: zoomPan, pinchZoomModifier, extendZoomModifier)

        return modifierGroup
    }

}

class RoundCornerCandlestickChartView: SCIFastCandlestickRenderableSeries {

    var topEllipsesBuffer = SCIFloatValues()
    var rectsBuffer = SCIFloatValues()
    var bottomEllipsesBuffer = SCIFloatValues()

    override init() {
        super.init(renderPassData: SCIColumnRenderPassData(),
                   hitProvider: SCICandlestickHitProvider(),
                   nearestPointProvider: SCINearestOhlcPointProvider())
    }

    override func disposeCachedData() {
        super.disposeCachedData()

        topEllipsesBuffer.dispose()
        rectsBuffer.dispose()
        bottomEllipsesBuffer.dispose()
    }

    override func internalDraw(with renderContext: ISCIRenderContext2D!, assetManager: ISCIAssetManager2D!, renderPassData: ISCISeriesRenderPassData!) {

        // Don't draw transparent series
        guard self.opacity != 0 else { return }
        let _ = renderPassData as! SCIOhlcRenderPassData
        // WIP

    }

//    fileprivate func updateDrawingBuffersWithData(renderPassData: SCIOhlcRenderPassData, columnPixelWidth: Float, zeroLine: Float) {
//        let halfWidth = columnPixelWidth / 2;
//
//        topEllipsesBuffer.count = renderPassData.pointsCount * 4
//        rectsBuffer.count = renderPassData.pointsCount * 4
//        bottomEllipsesBuffer.count = renderPassData.pointsCount * 4
//
//        for i in 0 ..< renderPassData.pointsCount {
//            let x = renderPassData.xCoords.getValueAt(i)
//            let y = renderPassData.
//
//            topEllipsesBuffer.set(x - halfWidth, at: i * 4 + 0)
//            topEllipsesBuffer.set(y, at: i * 4 + 1)
//            topEllipsesBuffer.set(x + halfWidth, at: i * 4 + 2)
//            topEllipsesBuffer.set(y - columnPixelWidth, at: i * 4 + 3)
//
//            rectsBuffer.set(x - halfWidth, at: i * 4 + 0)
//            rectsBuffer.set(y - halfWidth, at: i * 4 + 1)
//            rectsBuffer.set(x + halfWidth, at: i * 4 + 2)
//            rectsBuffer.set(zeroLine + halfWidth, at: i * 4 + 3)
//
//            bottomEllipsesBuffer.set(x - halfWidth, at: i * 4 + 0)
//            bottomEllipsesBuffer.set(zeroLine + columnPixelWidth, at: i * 4 + 1)
//            bottomEllipsesBuffer.set(x + halfWidth, at: i * 4 + 2)
//            bottomEllipsesBuffer.set(zeroLine, at: i * 4 + 3)
//        }
//    }



}
