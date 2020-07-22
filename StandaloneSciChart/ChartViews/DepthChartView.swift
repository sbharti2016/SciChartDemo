//
//  DepthChartView.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/8/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import SciChart

class DepthChartView: UIView {

    static func chart() -> SCIChartSurface {
        let surface: SCIChartSurface = SCIChartSurface()
        update(surface)
        return surface
    }

    static func update(_ surface: SCIChartSurface) {

        let xBottomAxis = SCINumericAxis()
        //        xBottomAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        xBottomAxis.textFormatting = "$"
        xBottomAxis.drawMinorTicks = false
        xBottomAxis.drawMajorTicks = false
        xBottomAxis.drawMajorBands = false
        xBottomAxis.drawMinorGridLines = false
        xBottomAxis.drawMajorGridLines = false

        let yRightAxis = SCINumericAxis()

        //Note:-  This is adding space on the left and right by 0.1 block
        //        yRightAxis.growBy = SCIDoubleRange(min: 0.1, max: 0.1)
        yRightAxis.axisAlignment = .right
        yRightAxis.textFormatting = "k"


        let yLeftAxis = SCINumericAxis()
        yLeftAxis.axisAlignment = .left

        yLeftAxis.drawMinorTicks = false
        yLeftAxis.drawMajorTicks = false
        yLeftAxis.drawMajorBands = false
        yLeftAxis.drawMinorGridLines = false
        yLeftAxis.drawMajorGridLines = false

        let dataSeries1 = SCIXyDataSeries(xType: .double, yType: .double)
        let dataSeries2 = SCIXyDataSeries(xType: .double, yType: .double)

        let dataSeries3 = SCIXyDataSeries(xType: .double, yType: .double)
        let dataSeries4 = SCIXyDataSeries(xType: .double, yType: .double)

        let coordinates = RandomUtility.getExponentialCurveWith(exponent: 1.8, and: 50)

        var xValues1: [Double] = []
        var yValues1: [Double] = []
        for index in 0 ..< coordinates.count {
            xValues1.append(coordinates[index].0)
            yValues1.append(1106.0 - coordinates[index].1)
        }
        dataSeries1.append(x: xValues1, y: yValues1)

        var xValues2: [Double] = []
        var yValues2: [Double] = []
        for index in 0 ..< coordinates.count {
            xValues2.append(106.0 + coordinates[index].0)
            yValues2.append(coordinates[index].1)
        }
        dataSeries2.append(x: xValues2, y: yValues2)

        var xValues3: [Double] = [xValues1[0]]
        var yValues3: [Double] = []
        var yDenominator = 0.0
        for index in 0 ..< xValues1.count {
            xValues3.append(xValues1[index])
            yValues3.append(yValues1[index] + (300 - yDenominator))

            if index < 35 {
                yDenominator += 0.0
            } else {
                yDenominator += 19.0
            }

        }
        dataSeries3.append(x: xValues3, y: yValues3)

        var xValues4: [Double] = []
        var yValues4: [Double] = []
        yDenominator = 0.0
        for index in 0 ..< xValues1.count {
            xValues4.append(106.0 + xValues1[index])
            yValues4.append(yValues2[index] + yDenominator)
            yDenominator += 5.0
        }
        dataSeries4.append(x: xValues4, y: yValues4)


        let series1 = SCISplineMountainRenderableSeries()
        series1.dataSeries = dataSeries1
        series1.areaStyle = SCILinearGradientBrushStyle(start:UIColor(displayP3Red: 91/255.0, green: 143.0/255.0, blue: 124.0/255.0, alpha: 1.0),
                                                        end: UIColor(displayP3Red: 91/255.0, green: 143.0/255.0, blue: 124.0/255.0, alpha: 1.0))
        series1.strokeStyle = SCISolidPenStyle(colorCode: 0xAA779D8F, thickness: 2.0)

        let series2 = SCISplineMountainRenderableSeries()
        series2.dataSeries = dataSeries2
        series2.areaStyle = SCILinearGradientBrushStyle(start:UIColor(displayP3Red: 125.0/255.0, green: 71.0/255.0, blue: 95.0/255.0, alpha: 1.0),
                                                        end: UIColor(displayP3Red: 125.0/255.0, green: 71.0/255.0, blue: 95.0/255.0, alpha: 1.0))
        series2.strokeStyle = SCISolidPenStyle(colorCode: 0xAA88576E, thickness: 2.0)

        let series3 = SCIFastMountainRenderableSeries()
        series3.dataSeries = dataSeries3
        series3.isDigitalLine = true
        series3.areaStyle = SCILinearGradientBrushStyle(start: UIColor(displayP3Red: 64.0/255.0, green: 123.0/255.0, blue: 100.0/255.0, alpha: 0.6),
                                                        end: UIColor(displayP3Red: 93.0/255.0, green: 138.0/255.0, blue: 120.0/255.0, alpha: 1.0))
        series3.strokeStyle = SCISolidPenStyle(colorCode: 0xAA8CD4AA, thickness: 2.0)

        let series4 = SCIFastMountainRenderableSeries()
        series4.dataSeries = dataSeries4
        series4.isDigitalLine = true
        series4.areaStyle = SCILinearGradientBrushStyle(start:UIColor(displayP3Red: 108.0/255.0, green: 44.0/255.0, blue: 72.0/255.0, alpha: 0.6),
                                                        end: UIColor(displayP3Red: 108.0/255.0, green: 44.0/255.0, blue: 72.0/255.0, alpha: 0.7))
        series4.strokeStyle = SCISolidPenStyle(colorCode: 0xAAB13759, thickness: 2.0)

        // annotations

        let annotationsCollection: SCIAnnotationCollection = SCIAnnotationCollection()
        var incrementor = 0.0
        for _ in 1 ... 6 {
            let boxAnnotation = SCIBoxAnnotation()
            boxAnnotation.set(x1: 29.8 + incrementor)
            boxAnnotation.set(y1: 0.0)
            boxAnnotation.set(x2: 30.2 + incrementor)
            boxAnnotation.set(y2: 1600.0)
            boxAnnotation.fillBrush = SCILinearGradientBrushStyle(start: CGPoint(x: 1.0, y: 1.0), end: CGPoint(x: 1.0, y: 0.0), start: UIColor.lightGray, end: UIColor.clear)
            boxAnnotation.borderPen = SCISolidPenStyle(color: UIColor.clear, thickness: 1.0)

            incrementor += 30.0
            annotationsCollection.add(items: boxAnnotation)
        }

        let lineAnnotation = SCILineAnnotation()
        lineAnnotation.set(x1: 106.0)
        lineAnnotation.set(y1: 0.0)
        lineAnnotation.set(x2: 106.0)
        lineAnnotation.set(y2: 730.0)
        lineAnnotation.stroke = SCISolidPenStyle(colorCode: 0xFF555555, thickness: 3)

        annotationsCollection.add(items: lineAnnotation)

        surface.annotations = annotationsCollection

        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(xBottomAxis)
            surface.yAxes.add(items: yLeftAxis)
            surface.renderableSeries.add(items: series1, series2, series3, series4)
            surface.chartModifiers.add(self.createDefaultModifiers())
        }

    }

    static func createDefaultModifiers() -> SCIModifierGroup {

        let zoomPan: SCIZoomPanModifier = SCIZoomPanModifier()
        zoomPan.receiveHandledEvents = true
        let pinchZoomModifier = SCIPinchZoomModifier()

        let extendZoomModifier = SCIZoomExtentsModifier()

        let rolloverModifier = SCIRolloverModifier()
        rolloverModifier.showTooltip = true

        let modifierGroup: SCIModifierGroup = SCIModifierGroup()
        modifierGroup.childModifiers.add(items: extendZoomModifier, pinchZoomModifier, rolloverModifier)
        return modifierGroup
    }

}
