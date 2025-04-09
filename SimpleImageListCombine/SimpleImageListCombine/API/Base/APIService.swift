//
//  APIService.swift
//  SimpleImageListCombine
//
//  Created by 배정환 on 4/5/25.
//
import Foundation
import Combine

enum APIError: Error, Equatable {
    case invalidURL
    case noData
    case decodingFailed
    case networkError(Error)
    case invalidStatusCode(Int)

    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.noData, .noData),
            (.decodingFailed, .decodingFailed):
            return true
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return (lhsError as NSError).domain == (rhsError as NSError).domain &&
            (lhsError as NSError).code == (rhsError as NSError).code
        case (.invalidStatusCode(let lhsCode), .invalidStatusCode(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
}

class APIHelperCombine {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    static func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        queryParameters: [String: Any]? = nil,
        body: [String: Any]? = nil,
        headers: [String: Any]? = nil
    ) -> AnyPublisher<T, APIError> {
        guard let components = URLComponents(string: url),
              let url = components.url,
              let scheme = components.scheme,
              !scheme.isEmpty,
              let host = components.host,
              !host.isEmpty else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        var urlComponents = components
        if method == .get, let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }

        guard let finalURL = urlComponents.url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue

        headers?.forEach { key, value in
            if let stringValue = value as? String {
                request.addValue(stringValue, forHTTPHeaderField: key)
            } else {
                request.addValue("\(value)", forHTTPHeaderField: key)
            }
        }

        if let body = body, method == .post || method == .put {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                return Fail(error: APIError.networkError(error)).eraseToAnyPublisher()
            }
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.networkError(NSError(domain: "APIHelper",
                                                        code: 0,
                                                        userInfo: [NSLocalizedDescriptionKey: "Invalid response"]
                                                       ))
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidStatusCode(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else if error is DecodingError {
                    return APIError.decodingFailed
                } else {
                    return APIError.networkError(error)
                }
            }
            .eraseToAnyPublisher()
    }

    // 편의 메서드들
    static func get<T: Decodable>(
        url: String,
        queryParameters: [String: Any]? = nil,
        headers: [String: Any]? = nil
    ) -> AnyPublisher<T, APIError> {
        request(url: url, method: .get, queryParameters: queryParameters, headers: headers)
    }

    static func post<T: Decodable>(
        url: String,
        body: [String: Any],
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, APIError> {
        request(url: url, method: .post, body: body, headers: headers)
    }

    static func put<T: Decodable>(
        url: String,
        body: [String: Any],
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, APIError> {
        request(url: url, method: .put, body: body, headers: headers)
    }

    static func delete<T: Decodable>(
        url: String,
        queryParameters: [String: Any]? = nil,
        headers: [String: Any]? = nil
    ) -> AnyPublisher<T, APIError> {
        request(url: url, method: .delete, queryParameters: queryParameters, headers: headers)
    }
}
