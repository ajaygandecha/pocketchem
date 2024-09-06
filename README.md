# PocketChem for iOS

![GitHub Release](https://img.shields.io/github/v/release/ajaygandecha/pocketchem)
![Swift](https://img.shields.io/badge/-Swift-05122A?style=flat&logo=swift)
![SwiftUI](https://img.shields.io/badge/-SwiftUI-05122A?style=flat&logo=swift&logoColor=03c3ff)
![Swift Testing](https://img.shields.io/badge/-Swift_Testing-05122A?style=flat&logo=swift&logoColor=48a424)

> Developed by [Ajay Gandecha](https://github.com/ajaygandecha) and released to the iOS App Store.

( Image here )

PocketChem is a periodic table and chemistry reference app designed for iOS devices, written purely with Swift and SwiftUI.

I first developed PocketChem in high school over four years ago to help high school students in their chemistry classes. PocketChem 2.0 is a complete rewrite of the original PocketChem, including a brand-new design, full landscape orientation support for iPad, and fixes many bugs that existed on the previous version.

PocketChem was first released while I was in my first ever programming class in high school. Now that I am in my final semester of undergrad studies, it has been super fun to revisit this older project and update it using all of the techniques I have learned over the last four years!

For instructional and portfolio value, PocketChem's source code is available for viewing here on this GitHub page. This README file also includes some notes on PocketChem's architecture and design.

## Features

### Notes on Chemical Equation Balancing


## Architecture

PocketChem utilizes the MV architecture

The app also utilizes modularization. The core PocketChem target solely includes screens and specialized views. All of the models and data used to power the application is placed in a separate, standalone `Data` package that lives in the PocketChem project. The `Tools` package includes all of the business logic, helpful extensions, and service structs. These services include the business logic for the chemical equation balancer, empiricial formula solver, etc. The `Tools` package depends on the `Data` package to accept and work with the necessary data models. Finally, a separate `Design` package, decoupled from the `Data` and `Tools` packages, include separate global-level shared views and design-related extensions. The PocketChem target then embeds the `Data`, `Tools`, and `Design` packages to include all of the necessary models, functionalities, and design components.

This modularization approach is great for a few reasons. For one, it makes the organization of the application source code much more intentional and easy to work with, as related code and functionality are packaged together. It also creates more clear and concrete abstraction barriers and prevents the design and architecture of the app to include over-coupling and circular dependencies. Apple's sample [Backyards Birds App](https://github.com/apple/sample-backyard-birds/tree/main) utilizes this approach, defining two separate Data and UI packages. The open-source [Ice Cubes App](https://github.com/Dimillian/IceCubesApp/tree/main) also shows this approach at scale. 

Modularization also enables better organization of unit and integration testing since each package can be tested separately (as described in the section below).

## Testing

The `Tools` package within the PocketChem project contains most of the business logic and functionality that must be tested. The test files for the `Tools` package are included in the package, and the testing for each package can be run separately. PocketChem utilizes the new [Swift Testing](https://developer.apple.com/xcode/swift-testing/) framework for testing the `Tools` package. Swift Testing seeks to augment (and replace, eventually) the old `XCTest` framework and makes testing far easier and idiomatic within Swift.

Through the testing in the package, the `Tools` package testing passes 100% of tests and the package has nearly 100% testing code coverage.
