import Foundation
import SwiftKeychainWrapper
import ObjectMapper

protocol AppKeychain {
    func save(_ user: User)
    func readUser() -> User?
    func removeUser()
    func save(token: String?)
    func readToken() -> String?
    func removeToken()
}

struct AppKeychainKey {
    static let user = "user_key"
    static let token = "token_key"
}

class DefaultAppKeychain: AppKeychain {
    static let shared = DefaultAppKeychain()

    private init() {
    }

    func clear() {
        removeUser()
    }

    func save(token: String?) {
        guard let token = token else { return }
        KeychainWrapper.standard.set(token, forKey: AppKeychainKey.token)
    }

    func readToken() -> String? {
        guard let token = KeychainWrapper.standard.string(forKey: AppKeychainKey.token) else {
//            log.info("Could not read token")
            return nil
        }
        return token
    }

    func removeToken() {
        KeychainWrapper.standard.removeObject(forKey: AppKeychainKey.token)
    }

    func save(_ user: User) {
        guard let userString = Mapper<User>().toJSONString(user) else {
//            log.error("Could not map user")
            return
        }
        KeychainWrapper.standard.set(userString, forKey: AppKeychainKey.user)
    }

    func readUser() -> User? {
        guard let userString = KeychainWrapper.standard.string(forKey: AppKeychainKey.user) else {
//            log.error("No user saved in Store.")
            return nil
        }
        guard let user = Mapper<User>().map(JSONString: userString) else {
//            log.error("Could not map user")
            return nil
        }
        return user
    }

    func removeUser() {
        KeychainWrapper.standard.removeObject(forKey: AppKeychainKey.user)
    }
}
