## Appistack Swift

An Appistack iOS 8 template, written in Swift 2.0.  

## Configuring For Multiple Environments

#### 1) Configure DNS for your API

In staging & production, you can connect to your API running in Heroku.  In development, you'll need to add an 
entry to `/etc/hosts` for your API.  The Appistack iOS template is configured to connect to `api.appistack.dev` 
in development.

#### 2) Configure NSExceptionDomains for your API

If you're API is served on HTTPS, you can skip this step.

If you're serving your API with HTTP, add a new key to `Info.plist` under `NSExceptionDomains`.  Use your API's 
root domain name, e.g. `appistack.dev`.  Set the type to Dictionary.  Add two keys: `NSIncludesSubdomains` 
and `NSTemporaryExceptionAllowsInsecureHTTPLoads`.  Set both to `YES`.

#### 3) Configure the Plist for your Environment.

Each environment has a `[environment]Config.plist` file, where environment-specific settings can be configured.

`api_base_url` - The API base URL, including the host and port number.

`assets_url` - The base URL for your assets.  If you're assets are stored in multiple locations, you may need 
additional configuration keys. 

`signup_confirm_success_url` - The URL passed to DeviseTokenAuth when a new user is created.  When the user clicks the link 
in their confirmation email, they will be redireced here after the API confirms their token.

`password_reset_success_url` - The URL passed to DeviseTokenAuth when a user requests a password change.  When the user clicks the 
link in their password change email, they will be redireced here after the API confirms their token.

## Running the App

Open XCode.  Hit CMD-R and hopefully it builds ;]

Alamofire 2.0.0-beta.1 requires XCode7 beta5 to build, so you may need to download that.
