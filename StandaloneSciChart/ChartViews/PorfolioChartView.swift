//
//  PorfolioChartView.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 7/20/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import UIKit
import SciChart

class PorfolioChartView: UIView  {

    var surface: SCIChartSurface = SCIChartSurface()
    var rSeries = SCIFastMountainRenderableSeries()
    var dateValues: [Double] = []
    var priceValues: [Double] = []
    var isDarkMode: Bool = false
    var xAxis = SCIDateAxis()
    var yAxis = SCINumericAxis()

    var gradiantStartingColor: UIColor = UIColor.clear
    var gradiantEndColor: UIColor = UIColor(red: 25.0/255, green: 174.0/255, blue: 166.0/255, alpha: 0.7)
    var penStrokeColor: UIColor = UIColor(red: 10.0/255, green: 186.0/255, blue: 181.0/255, alpha: 1.0)
    var strokeThickness: Float = 1.5

    override init(frame: CGRect) {
        super.init(frame: frame)
        update(surface)
        surface.frame = self.bounds
        self.addSubview(surface)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func chart() -> SCIChartSurface {
        let surface: SCIChartSurface = SCIChartSurface()
        update(surface)
        return surface
    }

    func update(_ surface: SCIChartSurface) {

        xAxis.axisAlignment = .bottom

        xAxis.textFormatting = "dd/MM"
        xAxis.subDayTextFormatting = "h:mm"
        xAxis.isCenterAxis = true

        // hides the x-axis labels
        // xAxis.drawLabels = false

        // Gets or sets auto range mode for current axis.
        xAxis.autoRange = .always

        // removing x-axis lines background
        xAxis.drawGridLineFor(majorGridLines: true)

        // hides the y-axis labels
        // yAxis.drawLabels = false

        // Gets or sets auto range mode for current axis.
//        yAxis.autoRange = .always
        yAxis.axisAlignment = .right

        // responsible for plotting chart underneath y-axis
        yAxis.isCenterAxis = true

        // removing y-axis lines background
        yAxis.drawGridLineFor(majorGridLines: true)
        yAxis.growBy = SCIDoubleRange(min: 1, max: 1.0)

        // display points in this range
        // yAxis.visibleRange = SCIDoubleRange(min: 11000.0, max: 13000.0)

        // remove chart border
        surface.renderableSeriesAreaBorderStyle = SCIPenStyle(thickness: 0.0, antiAliasing: false, strokeDashArray: nil)

        // Chart line
        rSeries.strokeStyle = SCISolidPenStyle(color: penStrokeColor, thickness: strokeThickness)

        // gradiant under chart
        rSeries.areaStyle = SCILinearGradientBrushStyle(start: CGPoint(x: 0.0, y: 0.3),
                                                        end: CGPoint(x: 0.0, y: 1.0),
                                                        start: gradiantStartingColor,
                                                        end: gradiantEndColor)

        // plotting of points on chart
        updateSeriesWith(datePoints: RandomUtility.getDatesFor(days: 1),
                         and: RandomUtility.getDrawablePointsFor(days: 1))

        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(self.xAxis)
            surface.yAxes.add(self.yAxis)
            surface.renderableSeries.add(self.rSeries)
            surface.zoomExtents()
            surface.chartModifiers.add(self.createDefaultModifiers())

            // Rendering series on the chart with animation
            // SCIAnimations.sweep(rSeries, duration: 3.0, easingFunction: SCICubicEase())
        }
    }

    func createDefaultModifiers() -> SCIModifierGroup {

        let zoomPan: SCIZoomPanModifier = SCIZoomPanModifier()
        zoomPan.receiveHandledEvents = true

        let pinchZoomModifier = SCIPinchZoomModifier()
        pinchZoomModifier.isUniformZoom = true

//        let rolloverModifier = SCIRolloverModifier()
//        let legend = SCILegendModifier()
//        legend.showCheckBoxes = true
//        let extendZoomModifier = SCIZoomExtentsModifier()
//        let xAxisDragmodifier = SCIXAxisDragModifier()
//        let yAxisDragmodifier = SCIYAxisDragModifier()
//        let toolTipModifier = SCITooltipModifier()

        let modifierGroup: SCIModifierGroup = SCIModifierGroup()
        modifierGroup.childModifiers.add(items: zoomPan, pinchZoomModifier)
        return modifierGroup
    }
}

extension PorfolioChartView {

    public func updateSeriesWith(datePoints: [Double], and pricePoints: [Double]) {

//        limitingDataWith(dayCount: datePoints.count / 24)
        dateValues = datePoints
        priceValues = pricePoints

        let initialDateList: SCIDateValues = SCIDateValues(values: dateValues)
        let initialPriceData: SCIDoubleValues = SCIDoubleValues(values: priceValues)

        let dataSeries = SCIXyDataSeries(xType: .date, yType: .double)
        dataSeries.append(x: initialDateList, y: initialPriceData)

        rSeries.dataSeries = dataSeries
        // control y-axis start line
        rSeries.zeroLineY = 2000.0
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {

            if self.traitCollection.userInterfaceStyle == .light {
                SCIThemeManager.applyTheme(to: surface,
                                           withThemeKey: SCIChart_ExpressionLightStyleKey)

//                                self.surface.backgroundColor = .white
            } else {
//                                self.surface.backgroundColor = .black
                SCIThemeManager.applyTheme(to: surface,
                                           withThemeKey: SCIChart_SciChartv4DarkStyleKey)

            }
        }
    }

    func limitingDataWith(dayCount: Int) {
        // limiting the data display on x-axis
        let today = Date()
        let threeMonths = Calendar.current.date(byAdding: .day, value: dayCount, to: today) ?? Date()
        xAxis.visibleRange = SCIDateRange(min: today, max: threeMonths)
        //xAxis.minimalZoomConstrain = SCIDateIntervalUtil.fromDays(1) as ISCIComparable\
        xAxis.maximumZoomConstrain = SCIDateIntervalUtil.fromDays(Double(dayCount)) as ISCIComparable
    }

}
