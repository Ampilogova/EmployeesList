
## Build tools & versions used
 Xcode 13.3+ & iOS 15.4+
 
## Steps to run the app
// 1. Open EmployeesList.xcodeproj with XCode 13.3+.
// 2. Choose simulator.
// 3. Run the App
// Detailed instructions in the documentation: https://developer.apple.com/documentation/xcode/running-your-app-in-the-simulator-or-on-a-device

## What areas of the app did you focus on?
// 1. Clean and understandable code. 
// 2. Service oriented architecture + MVC.
// 3. Handling different type of errors and edge cases. 
// 4. Accessibility
// 5. Unit tests.

## What was the reason for your focus? What problems were you trying to solve?
// The project foundation is service-based architecture. Each individual piece of app logic incapsulated in the separate abstraction - service. Services covered by protocols and provided as initializer parameters. This approach allow to fake services in unit tests. 
// My solution handles all types of errors. Depends on the type of error the App will display an alert, show empty state or just print error to console. All network requests supports canceling. If the user reloaded the table several times, the previous request will be canceled.
// It's important to make apps accessible to everyone who uses Apple devices. My implementation supports Dynamic Type.

## How long did you spend on this project?
// It took me 4 hours to cover all the necessary requirements and unit tests. I took another extra hour to work on the design.

## Did you make any trade-offs for this project? What would you have done differently with more time?
//I love making more time for the visual design. If I had more time, I would work through edge cases when the name of the employee, email or other information is very long(for different device models).

## What do you think is the weakest part of your project?
// The app not optimized for large screens (iPad).

## Did you copy any code or dependencies? Please make sure to attribute them here!
// I found a solution for image loading and caching. Optimized and applied it to my project. I used similar network service implementation in the my current personal project.

## Is there any other information you’d like us to know?
// I love to write clean and easy to read code. To provide better modularization and testability.
