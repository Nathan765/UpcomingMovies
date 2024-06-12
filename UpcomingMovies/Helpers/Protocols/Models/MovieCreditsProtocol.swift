//
//  MovieCreditsProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 16/05/24.
//  Copyright © 2024 Alonso. All rights reserved.
//

import UpcomingMoviesDomain

protocol MovieCreditsProtocol {

    var cast: [CastProtocol] { get }
    var crew: [CrewProtocol] { get }

}

struct MovieCreditsProtocolAdapter: MovieCreditsProtocol {

    let cast: [CastProtocol]
    let crew: [CrewProtocol]

    init(_ movieCredits: MovieCredits) {
        self.cast = movieCredits.cast
        self.crew = movieCredits.crew
    }

}
