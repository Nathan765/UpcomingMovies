//
//  MovieProvider.swift
//  UpcomingMovies
//
//  Created by Alonso on 11/6/18.
//  Copyright © 2018 Alonso. All rights reserved.
//

import Foundation

enum MovieProvider {
    
    case getUpcoming(page: Int)
    case getPopular(page: Int)
    case getTopRated(page: Int)
    case getByGenreId(page: Int, genreId: Int)
    case search(searchText: String)
    case getDetail(id: Int)
    case getVideos(id: Int)
    case getReviews(page: Int, id: Int)
    case getSimilars(page:Int, id: Int)
    
}

// MARK: - Endpoint

extension MovieProvider: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getUpcoming:
            return "/3/movie/upcoming"
        case .getPopular:
            return "/3/movie/popular"
        case .getTopRated:
            return "/3/movie/top_rated"
        case .getByGenreId:
            return "/3/discover/movie"
        case .search:
            return "/3/search/movie"
        case .getDetail(let id):
            return "/3/movie/\(id)"
        case .getVideos(let id):
            return "/3/movie/\(id)/videos"
        case .getReviews(_, let id):
            return "/3/movie/\(id)/reviews"
        case .getSimilars(_, let id):
            return "/3/movie/\(id)/similar"
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .getUpcoming(let page):
            return ["page": page]
        case .getPopular(let page):
            return ["page": page]
        case .getTopRated(let page):
            return ["page": page]
        case .getByGenreId(let page, let genreId):
            return ["page": page,
                    "with_genres": genreId,
                    "sort_by": "release_date.desc"]
        case .search(let searchText):
            return ["query": searchText]
        case .getDetail, .getVideos:
            return nil
        case .getReviews(let page, _):
            return ["page": page]
        case .getSimilars(let page, _):
            return ["page": page]
        }
    }
    
}
