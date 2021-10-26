//
//  MovieSearch.swift
//  UpcomingMoviesDomain
//
//  Created by Alonso on 11/7/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

public struct MovieSearch {

    public let id: UUID
    public let searchText: String
    public let createdAt: Date

    public init(id: UUID, searchText: String, createdAt: Date) {
        self.id = id
        self.searchText = searchText
        self.createdAt = createdAt
    }

}
