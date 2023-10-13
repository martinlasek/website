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
        case a_003_texteditor_placeholder_result = "003_texteditor_placeholder_result.gif"
        case a_004_result_showcasing = "004_result_showcasing.gif"
        case a_004_create_new_project = "004_create_new_project.png"
        case a_004_select_swift_ui = "004_select_swift_ui.png"
        case a_004_starter_content_view = "004_starter_content_view.png"
        case a_004_styled_content_view = "004_styled_content_view.png"
        case a_004_first_state_showcase = "004_first_state_showcase.gif"

        var imgSrc: String {
            return "/articles/\(self.rawValue)"
        }
    }
}
