//
//  BrowsrAppTests.swift
//  BrowsrAppTests
//
//  Created by Andre Bortoli on 2/18/23.
//

import XCTest
import BrowsrLib
@testable import BrowsrApp

class BrowsrAppTests: XCTestCase {
    var cell: OrganizationCell!
    var viewModel: OrganizationCellViewModel!
    var organization: Item!

    override func setUp() {
        super.setUp()
        cell = OrganizationCell(style: .default, reuseIdentifier: "testCell")
        let json = """
        {
            "login": "errfree",
            "id": 44,
            "node_id": "MDEyOk9yZ2FuaXphdGlvbjQ0",
            "url": "https://api.github.com/orgs/errfree",
            "repos_url": "https://api.github.com/orgs/errfree/repos",
            "events_url": "https://api.github.com/orgs/errfree/events",
            "hooks_url": "https://api.github.com/orgs/errfree/hooks",
            "issues_url": "https://api.github.com/orgs/errfree/issues",
            "members_url": "https://api.github.com/orgs/errfree/members{/member}",
            "public_members_url": "https://api.github.com/orgs/errfree/public_members{/member}",
            "avatar_url": "https://avatars.githubusercontent.com/u/44?v=4",
            "description": null
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let organization = try! decoder.decode(Item.self, from: json)

        viewModel = OrganizationCellViewModel(organization: organization)
    }

    override func tearDown() {
        cell = nil
        viewModel = nil
        organization = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.nameLabel)
        XCTAssertNotNil(cell.avatarImageView)
        XCTAssertEqual(cell.avatarImageCache.name, "")
    }

    func testPrepareForReuse() {
        cell.configure(with: viewModel)
        cell.prepareForReuse()
        XCTAssertNil(cell.viewModel)
        XCTAssertNil(cell.nameLabel.text)
        XCTAssertNil(cell.avatarImageView.image)
    }

    func testConfigure() {
        cell.configure(with: viewModel)
        XCTAssertEqual(cell.viewModel?.name, "errfree")
        XCTAssertEqual(cell.nameLabel.text, "errfree")
    }

}

