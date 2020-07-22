//
//  DisplayChartiViewController.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/10/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import UIKit
import SciChart

class DisplayChartiViewController: UIViewController {

    var viewModel = DisplayChartiViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let sciChart = viewModel.chartSurface else {return}
        view.addSubview(sciChart)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.chartSurface?.frame = view.bounds
        viewModel.chartSurface?.center = view.center
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
