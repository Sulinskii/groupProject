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
    case login(user: LoginUser)
    case register(user: RegisterUser)
    case getMonument(id: Int)
    case addMonument(monument: AddMonument)
    case getAllMonuments
    case updateMonument(id: Int)

    func execute<T: Mappable>() -> Single<T> {
        return networkPerformer.performRequest(on: self).observeOn(MainScheduler.instance)
    }

    func execute<T: Mappable>() -> Single<[T]> {
        return networkPerformer.performRequest(on: self).observeOn(MainScheduler.instance)
    }
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://52.157.228.97:7050")!
    }
    
    var headers: [String : String]? {
        var basicHeaders = ["Content-Type":"application/json"]
        switch self {
        case .addMonument, .updateMonument:
            basicHeaders.updateValue(DefaultAppKeychain.shared.readToken()!, forKey: "Authorization")
        default: return basicHeaders
        }
        print(basicHeaders)
        return basicHeaders
    }
    
    public var path: String {
        switch self {
        case .login: return "/user/log-in"
        case .register: return "/user/register"
        case .getMonument(let id): return "/monuments/\(id)"
        case .addMonument: return "monuments/add"
        case .getAllMonuments: return "monuments/all"
        case .updateMonument(let id): return "monuments/approve/\(id)/monument"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMonument, .getAllMonuments: return HTTPMethod.get
        case .login, .register, .addMonument: return HTTPMethod.post
        case .updateMonument: return HTTPMethod.put
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .register(let user):
            let data = Mapper<RegisterUser>().toJSON(user)
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .login(let user):
            let data = Mapper<LoginUser>().toJSON(user)
            print(data)
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .addMonument(let monument):
            let data = Mapper<AddMonument>().toJSON(monument)
            print(data)
            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .getMonument, .updateMonument, .getAllMonuments: return .requestPlain
        default: return .requestPlain
        }
    }
}
