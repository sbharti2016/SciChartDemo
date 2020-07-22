//
//  OptionsTableViewController.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/10/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {

    let viewModel = OptionsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getChartFor(index: indexPath.row)
    }

    @IBAction func getChartFor(index: Int) {
        let chartType = OptionsViewModel.ChartType.allCases[index]
        viewModel.selectChart(type: chartType)
        performSegue(withIdentifier: "displayChart", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let displayViewController = segue.destination as? DisplayChartiViewController else {return}
        displayViewController.viewModel.chartSurface = viewModel.currentlySelectedChartSurface
    }

}


