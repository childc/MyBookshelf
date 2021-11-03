//
//  DetailViewController.swift
//  MyBookshelf
//
//  Created by childc on 2021/11/03.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    var isbn13: String?
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        
        if let isbn13 = isbn13 {
            viewModel.retrieveBookDetail(isbn13: isbn13)
        }
    }
    
    private func bindViewModel() {
        viewModel.bookDetail.bind { [weak self] bookDetail in
            DispatchQueue.main.async { [weak self] in
                self?.titleLabel.text = bookDetail?.title ?? ""
            }
        }
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
