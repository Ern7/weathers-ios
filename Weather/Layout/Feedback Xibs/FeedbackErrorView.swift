//
//  FeedbackError.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/07.
//

import Foundation
import UIKit

class FeedbackErrorView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    var needsToRefresh : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func commonInit(){
        //let viewFromXib = Bundle.main.loadNibNamed("SearchCategoriesView", owner: self, options: nil)![0] as! UIView
        let nib = UINib(nibName: "FeedbackErrorView", bundle: Bundle.main)
        let viewFromXib = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        viewFromXib.frame = self.bounds
        viewFromXib.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin]
        viewFromXib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.isUserInteractionEnabled = true
        addSubview(viewFromXib)
    }
    
    @IBAction func refresh(_ sender: Any) {
        self.needsToRefresh?()
    }
    
}
