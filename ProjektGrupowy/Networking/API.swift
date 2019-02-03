//
// Created by Artur Sulinski on 2019-02-02.
// Copyright (c) 2019 Artur Sulinski. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import ObjectMapper
import RxSwift

let networkPerformer = DefaultNetworkRequestPerformer()

enum API {
    case login(login: String, password: String)
    case register(name: String, surname: String, login: String, password: String)
    case getMonument(id: Int)
    case addMonument
    case getAllMonuments
    case updateMonument

    func execute<T: Mappable>() -> Single<T> {
        return networkPerformer.performRequest(on: self).observeOn(MainScheduler.instance)
    }

    func execute<T: Mappable>() -> Single<[T]> {
        return networkPerformer.performRequest(on: self).observeOn(MainScheduler.instance)
    }
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://52.157.229.83:7050")!
    }
    
    var headers: [String : String]? {
        var basicHeaders = ["":""]
        return basicHeaders
    }
    
    public var path: String {
        switch self {
        case .login: return "/user/log-in"
        case .register: return "/user/register"
        case .getMonument(let id): return "/monuments/\(id)"
        case .addMonument: return "monuments/add"
        case .getAllMonuments: return "monuments/all"
        case .updateMonument: return "monuments/update"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login, .getMonument, .getAllMonuments: return HTTPMethod.get
        case .register, .addMonument: return HTTPMethod.post
        case .updateMonument: return HTTPMethod.put
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .login, .getMonument, .addMonument, .updateMonument, .getAllMonuments: return .requestPlain
        default: return .requestPlain
        }
    }
}
