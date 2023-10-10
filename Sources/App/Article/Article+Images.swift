//
//  Article+Image.swift
//  website
//
//  Created by Martin Lasek on 10/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

extension Article {
    enum Image: String {
        case a_001_the_problem = "001_the_problem.png"
        case a_001_the_solution = "001_the_solution.png"

        case a_002_xcode_check_outgoing_connection = "002_xcode_check_outgoing_connection.png"

        var imgSrc: String {
            return "/articles/\(self.rawValue)"
        }
    }
}
