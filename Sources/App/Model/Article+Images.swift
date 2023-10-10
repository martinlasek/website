//
//  File.swift
//  
//
//  Created by Martin Lasek on 10/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

extension Article {
    enum Image: String {
        case a_001_the_problem = "001_the_problem.png"
        case a_001_the_solution = "001_the_solution.png"

        var imgSrc: String {
            return "/articles/\(self.rawValue)"
        }
    }
}
