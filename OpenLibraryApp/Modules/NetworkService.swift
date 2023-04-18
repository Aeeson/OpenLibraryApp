import Foundation

protocol NetworkServiceProtocol {
    func getBooksList(subject: String, completion: @escaping (Result<[Book], Error>) -> Void)
    func getCover(id: String, size: String, completion: @escaping (Result<Data, Error>) -> Void)
    func getBookInfo(for key: String, completion: @escaping (Result<Details, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private let baseCoverURL = "https://covers.openlibrary.org/b/id/"
    private let baseListURL = "https://openlibrary.org/subjects/"
    private let baseDetailsURL = "https://openlibrary.org"
    private let queue = DispatchQueue(label: "Network", qos: .background)
    
    func getBooksList(subject: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        queue.async {
            guard let url = URL(string: self.baseListURL + subject + ".json") else { return }
            var request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                if let data = data {
                    do {
                        var books: [Book] = []
                        let result: List = try JSONDecoder().decode(List.self, from: data)
                        for element in result.works {
                            books.append(element)
                        }
                        DispatchQueue.main.async {
                            completion(.success(books))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func getCover(id: String, size: String, completion: @escaping (Result<Data, Error>) -> Void) {
        queue.async {
            guard let url = URL(string: self.baseCoverURL + id + "-" + size + ".jpg") else { return }
            var request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                if let data = data {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                }
            }
            task.resume()
        }
    }
    
    func getBookInfo(for key: String, completion: @escaping (Result<Details, Error>) -> Void) {
        queue.async {
            guard let url = URL(string: self.baseDetailsURL + key + ".json") else { return }
            var request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                if let data = data {
                    do {
                        let result: Details = try JSONDecoder().decode(Details.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
}
