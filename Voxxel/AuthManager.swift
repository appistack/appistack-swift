//
// Created by David Conner on 6/11/15.
// Copyright (c) 2015 Voxxel. All rights reserved.
//

import Foundation
import SSKeychain

class AuthManager {
    static let SERVICE_NAME = "VoxxelApp",
        TOKEN_KEY = "token",
        TOKEN_TYPE_KEY = "token_type",
        TOKEN_CLIENT_KEY = "token_client",
        TOKEN_EXPIRY_KEY = "token_expiry",
        TOKEN_UID_KEY = "token_uid"

    class func token() -> String? {
        return getSecureValue(TOKEN_KEY)
    }

    class func tokenType() -> String? {
        return getSecureValue(TOKEN_TYPE_KEY)
    }

    class func client() -> String? {
        return getSecureValue(TOKEN_CLIENT_KEY)
    }

    class func expiry() -> String? {
        return getSecureValue(TOKEN_EXPIRY_KEY)
    }

    class func uid() -> String? {
        return getSecureValue(TOKEN_UID_KEY);
    }

    class func isLoggedIn() -> Bool {
        //better way to do this? revert to instantiated class?
        if token() != nil {
            //TODO: check if token is expired
            return true
        } else {
            return false
        }
    }

    class func getAccessToken() -> AccessTokenModel {
        let aToken = AccessTokenModel()
        aToken.token = token()
        aToken.tokenType = tokenType()
        aToken.client = client()
        aToken.expiry = expiry()
        aToken.uid = uid()
        return aToken
    }

    class func getSecureValue(key:String) -> String? {
        return SSKeychain.passwordForService(SERVICE_NAME, account:key)
    }

    class func setSecureValue(value:String?, forKey:String) {
        if let v = value {
            SSKeychain.setPassword(v, forService:SERVICE_NAME, account:forKey)
        } else {
            SSKeychain.deletePasswordForService(SERVICE_NAME, account:forKey)
        }
    }

    class func clearAccessToken() {
        setSecureValue(nil, forKey:TOKEN_KEY)
        setSecureValue(nil, forKey:TOKEN_TYPE_KEY)
        setSecureValue(nil, forKey:TOKEN_CLIENT_KEY)
        setSecureValue(nil, forKey:TOKEN_EXPIRY_KEY)
        setSecureValue(nil, forKey:TOKEN_UID_KEY)
    }

}
