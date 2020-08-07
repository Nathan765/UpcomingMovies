//
//  SearchMoviesProtocols.swift
//  UpcomingMovies
//
//  Created by Alonso on 6/28/20.
//  Copyright © 2020 Alonso. All rights reserved.
//

import UIKit
import UpcomingMoviesDomain

protocol SearchMoviesCoordinatorProtocol: class {
    
    @discardableResult
    func embedSearchOptions(on parentViewController: UIViewController,
                            in containerView: UIView) -> SearchOptionsTableViewController
    
    @discardableResult
    func embedSearchController(on parentViewController: SearchMoviesResultControllerDelegate) -> DefaultSearchController

    func showMovieDetail(for movie: Movie)
    func showMovieDetail(for movieId: Int, and movieTitle: String)
    func showMoviesByGenre(_ genreId: Int, genreName: String)
    func showDefaultSearchOption(_ option: DefaultSearchOption)
    
}

// MARK: - Search movies result

protocol SearchMoviesResultViewModelProtocol {
    
    var viewState: Bindable<SearchMoviesResultViewState> { get }
    
    var recentSearchCells: [RecentSearchCellViewModelProtocol] { get }
    var movieCells: [MovieCellViewModelProtocol] { get }
    
    func searchMovies(withSearchText searchText: String)
    func searchedMovie(at index: Int) -> Movie
    
    func clearMovies()
    
}

protocol SearchMoviesResultInteractorProtocol {
    
    func searchMovies(searchText: String, page: Int?, completion: @escaping (Result<[Movie], Error>) -> Void)
    
    func getMovieSearches() -> [MovieSearch]
    func saveSearchText(_ searchText: String)
    
}

// MARK: - Search options

protocol SearchOptionsViewModelProtocol {
    
    var viewState: Bindable<SearchOptionsViewState> { get }
    var needsContentReload: (() -> Void)? { get set }
    var updateVisitedMovies: Bindable<Int?> { get }
    
    var selectedDefaultSearchOption: Bindable<DefaultSearchOption?> { get }
    var selectedMovieGenre: Bindable<(Int?, String?)> { get }
    var selectedRecentlyVisitedMovie: ((Int, String) -> Void)? { get set }
    
    var visitedMovieCells: [VisitedMovieCellViewModelProtocol] { get }
    var genreCells: [GenreSearchOptionCellViewModelProtocol] { get }
    
    var defaultSearchOptionsCells: [DefaultSearchOptionCellViewModelProtocol] { get }
    
    func loadGenres()
    
    func section(at index: Int) -> SearchOptionsSection
    func sectionIndex(for section: SearchOptionsSection) -> Int?
    
    func buildRecentlyVisitedMoviesCell() -> RecentlyVisitedMoviesCellViewModelProtocol
    
    func getDefaultSearchSelection(by index: Int)
    func getMovieGenreSelection(by index: Int)
    func getRecentlyVisitedMovieSelection(by index: Int)
    
}

protocol SearchOptionsInteractorProtocol {
    
    var didUpdateMovieVisit: (() -> Void)? { get set }
    
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
    
    func getMovieVisits() -> [MovieVisit]
    func hasMovieVisits() -> Bool
    
}

protocol SearchOptionsTableViewControllerDelegate: UIViewController {
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectDefaultSearchOption option: DefaultSearchOption)
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectMovieGenreWithId genreId: Int, andGenreName genreName: String)
    
    func searchOptionsTableViewController(_ searchOptionsTableViewController: SearchOptionsTableViewController,
                                          didSelectRecentlyVisitedMovie id: Int,
                                          title: String)
    
}
