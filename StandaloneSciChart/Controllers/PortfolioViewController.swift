//
//  PortfolioViewController.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 7/20/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {

    @IBOutlet var chartContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let chartView = PorfolioChartView(frame: chartContainerView.bounds)
        chartContainerView.addSubview(chartView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
