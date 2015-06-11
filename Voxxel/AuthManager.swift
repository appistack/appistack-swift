//
// Created by David Conner on 6/11/15.
// Copyright (c) 2015 Voxxel. All rights reserved.
//

import Foundation

class AuthManager {
    let SERVICE_NAME = "VoxxelApp",
        TOKEN_KEY = "token",
        TOKEN_TYPE_KEY = "token_type",
        TOKEN_CLIENT_KEY = "token_client",
        TOKEN_EXPIRY_KEY = "token_expiry",
        TOKEN_UID_KEY = "token_uid"

    func token() -> String {
        return getSecureValue(TOKEN_KEY)
    }

    func tokenType() -> String {
        return getSecureValue(TOKEN_TYPE_KEY)
    }

    func client() -> String {
        return getSecureValue(TOKEN_CLIENT_KEY)
    }

    func expiry() -> String {
        return getSecureValue(TOKEN_EXPIRY_KEY)
    }

    func uid() -> String {
        return getSecureValue(TOKEN_UID_KEY);
    }

    func isLoggedIn() -> Bool {
        return token() != nil
    }

    func getAccessToken() -> AccessToken {
        var aToken = AccessTokenModel()
        aToken.token = token()
        aToken.tokenType = tokenType()
        aToken.client = client()
        aToken.expiry = expiry()
        aToken.setUid = uid()
    }

    func getSecureValue(key:String) -> String {
        SSKeychain.passwordForService(SERVICE_NAME, account: key)
    }

    func setSecureValue(key:String, value:String) -> String {
        if (value) {
            SSKeychain.setPassword(value, forService:SERVICE_NAME, forKey:key)
        } else {
            SSKeychain.deletePasswordForService(SERVICE_NAME, account:key)
        }
    }

    func clearAccessToken() {
        setSecureValue(nil, forKey:TOKEN_KEY)
        setSecureValue(nil, forKey:TOKEN_TYPE_KEY)
        setSecureValue(nil, forKey:TOKEN_CLIENT_KEY)
        setSecureValue(nil, forKey:TOKEN_EXPIRY_KEY)
        setSecureValue(nil, forKey:TOKEN_UID_KEY)
    }

}
