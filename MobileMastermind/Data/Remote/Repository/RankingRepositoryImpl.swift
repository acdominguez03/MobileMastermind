//
//  RankingRepositoryImpl.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 12/5/25.
//

struct RankingRepositoryImpl: RankingRepositoryProtocol {
    
    let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource = RemoteDataSource.shared) {
        self.remote = remote
    }
    
    static let shared: RankingRepositoryProtocol = RankingRepositoryImpl(remote: RemoteDataSource.shared)
    
    func getUserRanking() async throws -> [RankingBO] {
        do {
            let result = try await remote.getRanking()
            return result.data.map { $0.toRankingBO }
        } catch {
            throw error
        }
    }
}
