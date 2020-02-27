//
//  SchoolDetailViewController.swift
//  MapKitNycSchoolsLab
//
//  Created by Tiffany Obi on 2/25/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    
    
    private var school : NYCSchools
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    @IBOutlet weak var addressCityStateZipLabel: UILabel!
    
    @IBOutlet weak var boroughLabel: UILabel!
    
    @IBOutlet weak var schoolWebsiteLabel: UILabel!
    
    
    init?(coder: NSCoder, school: NYCSchools) {
        self.school = school
        super.init(coder:coder)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(with: school)
    }
    
    func updateUI(with school: NYCSchools) {
        
        schoolNameLabel.text =
        school.schoolName
        
        addressCityStateZipLabel.text = "Address:  \(school.address) \n \(school.city), \(school.state) \n \(school.zip)"
        
        boroughLabel.text = "Borough: \(school.borough) "
        
        schoolWebsiteLabel.text = "School Website: \(school.website)"
        
        overviewTextView.text = school.overview
        
        
        
    }
    
}
