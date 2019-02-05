import Moya
import RxSwift
import Moya_ObjectMapper
import ObjectMapper

protocol NetworkRequestPerformer {
    func performRequest<T: Mappable>(on endpoint: API) -> Single<T>
    func performRequest<T: Mappable>(on endpoint: API) -> Single<[T]>
    func performWithoutMapping(request: API) -> Single<Response>
}

class DefaultNetworkRequestPerformer: NetworkRequestPerformer {
    
    private var provider: MoyaProvider<API>!

    init() {
        let manager = self.createManager()
        provider = MoyaProvider<API>(manager: manager)
    }

    private func createManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }

    func performWithoutMapping(request: API) -> Single<Response> {
        return provider.rx.request(request).breakIf20x()
    }

    func performRequest<T: Mappable>(on endpoint: API) -> Single<T> {
        return provider.rx.request(endpoint).breakIf20x().mapObject(T.self)
    }

    func performRequest<T: Mappable>(on endpoint: API) -> Single<[T]> {
        return provider.rx.request(endpoint).breakIf20x().mapArray(T.self)
    }

}

private extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    func breakIf20x() -> Single<Response> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .flatMap { (response: Response) -> Single<Response> in
                    return Single.create {
                        observer in
                        let statusCode: Int = response.statusCode
                        print(statusCode)
                        if ((statusCode >= 200 && statusCode < 300) || statusCode == 422)  {
                            observer(.success(response))
                        } else {
//                            log.info("descritpion: \(response.request)")
//                            log.info("response: \(response.)")
                        
                            observer(.error(MoyaError.statusCode(response)))
                        }
                        return Disposables.create()
                    }
                }
    }
}
