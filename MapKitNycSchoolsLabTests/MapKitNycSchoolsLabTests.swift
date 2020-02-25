//
//  MapKitNycSchoolsLabTests.swift
//  MapKitNycSchoolsLabTests
//
//  Created by Tiffany Obi on 2/25/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import XCTest
import NetworkHelper
@testable import MapKitNycSchoolsLab


class MapKitNycSchoolsLabTests: XCTestCase {

    func testNYCSchoolsApi() {
        let exp = XCTestExpectation(description: "search found")
        
        let nycSchoolsApi = "https://data.cityofnewyork.us/resource/uq7m-95z8.json"
        
        let request = URLRequest(url: URL(string: nycSchoolsApi)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
                
            case .success(let data):
                exp.fulfill()
                XCTAssertGreaterThan(data.count, 2_140_000, "data should be greater than \(data.count)")
                
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    
    func testApiForData() {
        
        
        struct NYCSchools: Codable & Equatable{
            let schoolName:String
            let overview: String
            let latitude: String
            let longitude: String
            
         enum CodingKeys: String,CodingKey {
                 case schoolName = "school_name"
                 case overview = "overview_paragraph"
                 case latitude
                 case longitude
         }

    }
      
        let expeditedName = "Brooklyn High School for Law and Technology"
        
        let json = """
        [{
            "dbn": "16K498",
            "school_name": "Brooklyn High School for Law and Technology",
            "boro": "K",
            "overview_paragraph": "The mission of Brooklyn High School for Law and Technology is to intellectually prepare, morally inspire, and socially motivate every student to become a leader in this vastly changing society. Our curriculum in biomedical science, engineering, software engineering, and law are blueprints for all students to succeed in any competitive college program. At Brooklyn High School for Law and Technology, the overall goal is to cultivate exceptional leaders prepared to serve and lead globally.",
            "school_10th_seats": "Y",
            "academicopportunities1": "iLearnNYC: Program for expanded online coursework and self-paced learning",
            "academicopportunities2": "Access to Law and Technology Programs: Youth Court, ESI, Civil Rights and Patent Law, Technology Program (provides experiences in web design)",
            "academicopportunities3": "Computer Programming, iCareers, Online courses; Volunteers mentor our scholars through community service internships",
            "academicopportunities4": "Multicultural Literature, Conflict Resolution/Peer Mediation, Debate, College and Career Prep, TV and Music Production Studio, CUNY College Now, Calculus",
            "ell_programs": "English as a New Language",
            "language_classes": "Spanish",
            "advancedplacement_courses": "AP Chemistry, AP English Language and Composition, AP English Literature and Composition, AP Environmental Science, AP Spanish",
            "diplomaendorsements": "Math",
            "neighborhood": "Bedford-Stuyvesant",
            "shared_space": "No",
            "building_code": "K987",
            "location": "1396 Broadway, Brooklyn NY 11221(40.688399, -73.920603)",
            "phone_number": "718-919-1256",
            "fax_number": "718-852-4593",
            "school_email": "Vjohnson5@schools.nyc.gov",
            "website": "bklawtech.com",
            "subway": "J, Z to Gates Ave",
            "bus": "B20, B26, B38, B46, B47, B52, B7, Q24",
            "grades2018": "9 to 12",
            "finalgrades": "9 to 12",
            "total_students": "594",
            "start_time": "8am",
            "end_time": "3pm",
            "psal_sports_boys": "Basketball, Outdoor Track",
            "psal_sports_girls": "Basketball, Indoor Track, Volleyball",
            "school_sports": "(NCAA Cleared) Boys: Baseball, Intramural Basketball, Fitness Center, Flag Football, Soccer, Softball, Track, Volleyball; Girls: Dance/Cheerleading, Double Dutch, Fitness Center, Intramural Basketball, Karate, Softball, Step Team, Track",
            "graduation_rate": "0.74",
            "attendance_rate": "0.85",
            "pct_stu_enough_variety": "0.58",
            "college_career_rate": "0.49",
            "pct_stu_safe": "0.74",
            "school_accessibility_description": "2",
            "prgdesc1": "Study of criminal, civil, and family law; politics, and social activism. Participation in internships and community service.",
            "prgdesc2": "Introduction to computer science through the use of current technology to provide students with job readiness skills.",
            "requirement1_1": "Attendance",
            "requirement2_1": "Punctuality",
            "requirement3_1": "Course Grades: English (65-100), Math (60-100), Science (64-100), Social Studies (56-100)",
            "requirement4_1": "Standardized Test Scores: English Language Arts (1.9-4.5), Math (1.5-4.5)",
            "program1": "Academy for Social Justice",
            "program2": "Computer Technology",
            "code1": "K49B",
            "code2": "K49D",
            "interest1": "Law & Government",
            "interest2": "Computer Science & Technology",
            "method1": "Screened",
            "method2": "Ed. Opt.",
            "seats9ge1": "63",
            "seats9ge2": "62",
            "grade9gefilledflag1": "N",
            "grade9gefilledflag2": "N",
            "grade9geapplicants1": "494",
            "grade9geapplicantsperseat1": "8",
            "grade9geapplicants2": "428",
            "grade9geapplicantsperseat2": "7",
            "seats9swd1": "13",
            "seats9swd2": "13",
            "grade9swdfilledflag1": "Y",
            "grade9swdfilledflag2": "Y",
            "grade9swdapplicants1": "94",
            "grade9swdapplicantsperseat1": "7",
            "grade9swdapplicants2": "89",
            "grade9swdapplicantsperseat2": "7",
            "seats101": "Yes-10",
            "seats102": "Yes-10",
            "admissionspriority11": "Open to New York City residents",
            "admissionspriority12": "Open to New York City residents",
            "primary_address_line_1": "1396 Broadway",
            "city": "Brooklyn",
            "zip": "11221",
            "state_code": "NY",
            "borough": "BROOKLYN ",
            "latitude": "40.688831",
            "longitude": "-73.920906",
            "community_board": "3",
            "council_district": "41",
            "census_tract": "375",
            "bin": "3039676",
            "bbl": "3014820001",
            "nta": "Stuyvesant Heights                                                         "
        }]
        """.data(using: .utf8)!
        
            let school = try! JSONDecoder().decode([NYCSchools].self, from: json)
        
        XCTAssertEqual(expeditedName, school.first?.schoolName, "the expected name - \(expeditedName) should be the same as schools.first.schoolName - \(school.first?.schoolName ?? "No name")")
    }

}
    

