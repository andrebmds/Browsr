//
//  Organizations.swift
//  BrowsrLib
//
//  Created by Andre Bortoli on 2/17/23.
//

import Foundation

// MARK: - Organization
struct Organization: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let url, reposURL, eventsURL, hooksURL: String?
    let issuesURL: String?
    let membersURL, publicMembersURL: String?
    let avatarURL: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case url
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case hooksURL = "hooks_url"
        case issuesURL = "issues_url"
        case membersURL = "members_url"
        case publicMembersURL = "public_members_url"
        case avatarURL = "avatar_url"
        case description
    }
}

typealias Organizations = [Organization]
