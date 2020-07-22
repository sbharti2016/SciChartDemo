//
//  Candle_ColumnViewController.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/29/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import SciChart

class Candle_ColumnViewController: UIViewController {

    @IBOutlet var candleSurface: SCIChartSurface!
    @IBOutlet var columnSurface: SCIChartSurface!

    let dataSeries = SCIOhlcDataSeries(xType: .date, yType: .double)

    let sharedXRange = SCIDoubleRange(min: 10, max: 40)
    let sharedYRange = SCIDoubleRange(min: 0, max: 0.1)

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTestData()

        //add charts
        prepareColumnChartSurfaceWithData()
        prepareCandellisticChartSurfaceWithData()
    }

    func prepareTestData() {
        let dateData = SCIDateValues(values: RandomUtility.getDatesOf(count: 247))

        // this price is in $(dollars)
        let open = SCIDoubleValues(values: RandomUtility.getOpenPrice())
        let high = SCIDoubleValues(values: RandomUtility.getHighPrice())
        let low = SCIDoubleValues(values: RandomUtility.getLowPrice())
        let close = SCIDoubleValues(values: RandomUtility.getClosePrice())

        dataSeries.append(x: dateData,
                          open: open, high: high, low: low, close: close)
    }

    func prepareCandellisticChartSurfaceWithData() {

        let xAxis = SCICategoryDateAxis()
        xAxis.growBy = SCIDoubleRange(min: 0, max: 0.1)
        xAxis.isVisible = false
        xAxis.hideBackground()

        let yAxis = SCINumericAxis()
        yAxis.hideBackground()
        yAxis.textFormatting = "$"
        yAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        yAxis.autoRange = .always

        xAxis.visibleRange = sharedXRange
        yAxis.visibleRange = sharedYRange

        let candellisticSeries = SCIFastCandlestickRenderableSeries()
        candellisticSeries.dataSeries = dataSeries


        candellisticSeries.strokeUpStyle = SCISolidPenStyle(color: UIColor(red: 64.0/255.0, green: 187.0/255.0, blue: 128.0/255.0, alpha: 1.0), thickness: 3.0)
        candellisticSeries.strokeDownStyle = SCISolidPenStyle(color: UIColor(red: 201.0/255.0, green: 49.0/255.0, blue: 88.0/255.0, alpha: 1.0), thickness: 3.0)

        candellisticSeries.fillUpBrushStyle = SCISolidBrushStyle(color: UIColor(red: 64.0/255.0, green: 187.0/255.0, blue: 128.0/255.0, alpha: 1.0))
        candellisticSeries.fillDownBrushStyle = SCISolidBrushStyle(color: UIColor(red: 201.0/255.0, green: 49.0/255.0, blue: 88.0/255.0, alpha: 1.0))



        SCIUpdateSuspender.usingWith(candleSurface) {
            self.candleSurface.xAxes.add(xAxis)
            self.candleSurface.yAxes.add(yAxis)
            self.candleSurface.renderableSeries.add(items: candellisticSeries)
            self.candleSurface.chartModifiers.add(self.createDefaultModifiers())
            SCIAnimations.wave(candellisticSeries, duration: 3.0, andEasingFunction: SCICubicEase())
        }
    }

    func prepareColumnChartSurfaceWithData() {

        let xAxis = SCICategoryDateAxis()
        let yAxis = SCINumericAxis()

        yAxis.isVisible = false

        xAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        yAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)

        xAxis.visibleRange = sharedXRange
        yAxis.visibleRange = sharedYRange

        let columnSeries = SCIFastColumnRenderableSeries()
        columnSeries.fillBrushStyle = SCISolidBrushStyle(colorCode: 0xff3cf3a6)
        columnSeries.dataSeries = dataSeries
//        columnSeries.paletteProvider = ColumnsTripleColorPalette()

        SCIUpdateSuspender.usingWith(columnSurface) {
            self.columnSurface.xAxes.add(xAxis)
            self.columnSurface.yAxes.add(yAxis)
            self.columnSurface.renderableSeries.add(items: columnSeries)
            self.columnSurface.chartModifiers.add(self.createDefaultModifiers())
            SCIAnimations.wave(columnSeries, duration: 3.0, andEasingFunction: SCICubicEase())
        }
    }

    func createDefaultModifiers() -> SCIModifierGroup {

        let zoomPan: SCIZoomPanModifier = SCIZoomPanModifier()
        zoomPan.receiveHandledEvents = true


        //           let xAxisDragmodifier = SCIXAxisDragModifier()
        //           let yAxisDragmodifier = SCIYAxisDragModifier()

        let rolloverModifier = SCIRolloverModifier()
        rolloverModifier.showTooltip = true

        let legend = SCILegendModifier()
        legend.showCheckBoxes = true

        //           let toolTipModifier = SCITooltipModifier()

        let modifierGroup: SCIModifierGroup = SCIModifierGroup()

        modifierGroup.receiveHandledEvents = true
        modifierGroup.childModifiers.add(items: zoomPan, SCIZoomExtentsModifier(), SCIPinchZoomModifier(), rolloverModifier, SCIXAxisDragModifier(), SCIYAxisDragModifier())

        return modifierGroup
    }

}
