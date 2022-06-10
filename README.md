# wallet-test

A demo project developed to showcase my technical background in iOS development. This application is built using Swift and UIKit, following a custom MVVM architecture.

## Getting Started

The project can be built using XCode and run on a simulator or device with internet connection.

### Installation

The project has CocoaPods dependencies found in the podfile. Cocoapods needs to be installed on the macOS machine and do a pod install via the terminal.

1. Clone the repository to your local maching
```
git clone https://github.com/masterpaulo/wallet-test.git
```
2. Open `wallet-test.xcodeproj` in XCode
3. Run the project


## Testing
The application is integrated with a Mock API using [mockable.io](https://www.mockable.io/a/#/space/demo3902611/rest). A sample domain containing different mock responses for the API requests are pre-configured to aid in testing this application. You can access the space in the link below:
>https://www.mockable.io/a/#/space/demo3902611/rest

Feel free to start/stop any mocks available for testing different scenarios.

#### API Request paths and their available mocks
###### /wallets

- GET /wallets (Status: 200 response) - returns a successful response with valid data
- GET /wallets (Status: 429 response) - returns an error 429 with custom error JSON response
- GET /wallets (Status: 500 response) - returns a server error

###### /histories
- GET /histories (Status : 200 response) - returns a successful response with valid data
- GET /histories (Status : 429 response) - returns an error 429 with custom error JSON response
- GET /histories (Status : 500 response) - returns a server error

> NOTE: Only one instance of a mock per path can be started from the mockable.io space.

## Application Logic
Here are some important points to note regarding the implementation of the application logic.
#### API Data handling
- All API response data are treated as JSON objects
- All attribute values are accepted by the application as **String** data even for numeric values
e.g.
```
{
   "id":"2001",
   "entry":"incoming",
   "amount":"100.23",
   "currency":"PHP",
   "sender":"John",
   "recipient":"You"
}
```
Both `id` and `amount` are accepted as **String** rather than **Int** or **Double** values. This values are displayed as is in the app without needing to obtain their numeric values since there are no computations necessary for the requirements of this demo.
- For `/histories` response data:
  - `"entry"` attribute can only have any of values below:
    - "ingoing"
    - "outgoing"
    - "cash-in"
    - "cash-out"
  - (I added 2 new entry types to differentiate normal payments/cashflow with cashing in/out transactions)
- All valid API response data are decoded into *Data Models* defined in the project. An exception for API error responses which are decoded into JSON objects directly without any model definition. *See below for more information*.

#### Error Handling
- The general error handling of the app is handled on the Network layer. Specifically the `RequestLoader` implementation. See [RequestLoader.swift](/wallet-test/Services/RequestLoader.swift)
- For the Main screen implementation, both sections (My Wallet, Histories) have their own separate request loader. They are implemented to each have independent states to manage events inclusively . For the error state of the sections, the app provides a reload function to demonstrate how each of them can handle state management for their scope only.
- The request loader process the response and returns a specific error type to the View Model layer, which is then used to describe what event/actions to do with it. Like logging in the console, or displaying a message to the user, or also possibly show an alert, etc.

## Requirements

- Xcode 13 or higher
- Minimum iOS deployment target of 13.0
- Internet connection (to install SPM packages)

## Built With

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Moya](https://github.com/Moya/Moya)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)


## Authors

- **John Paulo Bonacua**
