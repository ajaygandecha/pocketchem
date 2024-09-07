# PocketChem for iOS

![GitHub Release](https://img.shields.io/github/v/release/ajaygandecha/pocketchem)
![Swift](https://img.shields.io/badge/-Swift-05122A?style=flat&logo=swift)
![SwiftUI](https://img.shields.io/badge/-SwiftUI-05122A?style=flat&logo=swift&logoColor=03c3ff)
![Swift Testing](https://img.shields.io/badge/-Swift_Testing-05122A?style=flat&logo=swift&logoColor=48a424)

> Developed by [Ajay Gandecha](https://github.com/ajaygandecha) and released to the iOS App Store.

( Image here )

<p align="middle">
  <img src="https://github.com/user-attachments/assets/7835f521-828b-4585-b7ce-afe7bacaac33" width="100" />
  <img src="https://github.com/user-attachments/assets/b83c3cf4-9e7a-4b5e-b857-8480127d15e0" width="250" /> 
  <img src="/img3.png" width="100" />
</p>

![iOS - One](https://github.com/user-attachments/assets/7835f521-828b-4585-b7ce-afe7bacaac33) ![PocketChem Home Screen](https://github.com/user-attachments/assets/b83c3cf4-9e7a-4b5e-b857-8480127d15e0)

PocketChem is a periodic table and chemistry reference app designed for iOS devices, written purely with Swift and SwiftUI.

I first developed PocketChem in high school over four years ago to help high school students in their chemistry classes. PocketChem 2.0 is a complete rewrite of the original PocketChem, including a brand-new design, full landscape orientation support for iPad, and fixes many bugs that existed on the previous version.

PocketChem was first released while I was in my first ever programming class in high school. Now that I am in my final semester of undergrad studies, it has been super fun to revisit this older project and update it using all of the techniques I have learned over the last four years!

For instructional and portfolio value, PocketChem's source code is available for viewing here on this GitHub page. This README file also includes some notes on PocketChem's architecture and design.

## Features

## Architecture

PocketChem generally utilizes the MV architecture for managing state within its views. Despite having worked with MVVM in the past and exploring other architectures including The Composable Architecture (TCA), PocketChem does not include much state manipulation. States manipulated are pretty specific and local to each view. Data is also not manipulated extensively, only passed into service functions. Therefore, some of the more sophistocated architectures were not necessary for this project.

The app does utilize **modularization**. The core PocketChem target solely includes screens and specialized views. All of the models and data used to power the application is placed in a separate, standalone `Data` package that lives in the PocketChem project. The `Tools` package includes all of the business logic, helpful extensions, and service structs. These services include the business logic for the chemical equation balancer, empiricial formula solver, etc. The `Tools` package depends on the `Data` package to accept and work with the necessary data models. Finally, a separate `Design` package, decoupled from the `Data` and `Tools` packages, include separate global-level shared views and design-related extensions. The PocketChem target then embeds the `Data`, `Tools`, and `Design` packages to include all of the necessary models, functionalities, and design components.

![Note Sep 6, 2024](https://github.com/user-attachments/assets/a4ca2772-0893-4cb4-b3e5-097898f5f636)

This modularization approach is great for a few reasons. For one, it makes the organization of the application source code much more intentional and easy to work with, as related code and functionality are packaged together. It also creates more clear and concrete abstraction barriers and prevents the design and architecture of the app to include over-coupling and circular dependencies. Apple's sample [Backyards Birds App](https://github.com/apple/sample-backyard-birds/tree/main) utilizes this approach, defining two separate Data and UI packages. The open-source [Ice Cubes App](https://github.com/Dimillian/IceCubesApp/tree/main) also shows this approach at scale. 

Modularization also enables better organization of unit and integration testing since each package can be tested separately (as described in the section below).

## Testing

The `Tools` package within the PocketChem project contains most of the business logic and functionality that must be tested. The test files for the `Tools` package are included in the package, and the testing for each package can be run separately. PocketChem utilizes the new [Swift Testing](https://developer.apple.com/xcode/swift-testing/) framework for testing the `Tools` package. Swift Testing seeks to augment (and replace, eventually) the old `XCTest` framework and makes testing far easier and idiomatic within Swift.

Through the testing in the package, the `Tools` package testing passes 100% of tests and the package has nearly 100% testing code coverage.

## Implementing Chemistry Functionality

### Notes on Approaching Programmatic Chemical Equation Balancing

One of the biggest challenges for PocketChem was implementing the chemical equation balancer feature. Typically, balancing chemical equations is done with a bit of intuition and is not typically taught with in the formulaic context. However, in high school, I had just learned about matrices in pre-calculus class and we briefly covered how it can be used to solve linear equations. This type of math is ultimately at the heart of linear algebra - and we can apply linear algebra to solve these types of problems.

As an example, let's take the photosynthesis equation: $CO_2+H_2O \rightarrow C_6H_{12}O_6+O_2$. When balancing a chemical equation, we are trying to solve for coefficients before each chemical compound such that the number of each elements are equal between the left and right-hand sides of the equations. Let's represent these coefficients as variables $a_1,a_2,...a_n$, giving us this equation:

$$
a_1\left(CO_2\right)+a_2\left(H_2O\right) \rightarrow a_3\left(C_6H_{12}O_6\right)+a_4\left(O_2\right)
$$

From this, we can create a system of linear equations. We can separate these into equations *for each element*. The constant value we supply per compound is the number of each element in that compound. For example:

$$
\text{Equation for C  } \rightarrow 1a_1 + 0a_2 = 6a_3 + 0a_4 \rightarrow 1a_1 + 0a_2 - 6a_3 - 0a_4 = 0
$$

$$
\text{Equation for O  } \rightarrow 2a_1 + 1a_2 = 6a_3 + 2a_4 \rightarrow 2a_1 + 1a_2 - 6a_3 - 2a_4 = 0
$$

$$
\text{Equation for H  } \rightarrow 0a_1 + 2a_2 = 12a_3 + 0a_4 \rightarrow 0a_1 + 2a_2 - 12a_3 - 0a_4 = 0
$$

Now, we can write these equations in the form of matrices! In linear algebra, $Ax=b$ is the equation used to define systems of linear equations, where $A$ is the matrix of coefficients from the equations, $x$ is the matrix of the unknowns, and $b$ are the constants leftover. Based on the example with the photosynthesis equation, we can construct the matrix form of the systems of linear equations:

$$
\begin{bmatrix} 
1 & 0 & -6 & 0 \\
2 & 1 & -6 & -2 \\
0 & 2 & -12 & 0 \\
\end{bmatrix}
\begin{bmatrix} 
a_1 \\
a_2 \\
a_3 \\
a_4 \\
\end{bmatrix} = 
\begin{bmatrix} 
0 \\
0 \\
0 \\
\end{bmatrix}
$$

Out of this, we can construct an *augmented* matrix. The augmented matrix will include the columns from $A$ and the columns from $b$. To solve the system of equations, there should be an equal number of rows to the number of unknowns. Therefore, since our matrix only has 3 rows but we are solving for four unknowns ($a_1,a_2,a_3,a_4$), we can add one extra row of $0$s so that we have 4 rows, but do not mess up any of the equivalencies (we know 0 times all of the coefficients will equal 0!).

$$
\begin{bmatrix} 
1 & 0 & -6 & 0 & 0\\
2 & 1 & -6 & -2 & 0\\
0 & 2 & -12 & 0 & 0\\
0 & 0 & 0 & 0 & 0
\end{bmatrix}
$$

With this augmented matrix, we compute the *reduced-row echelon form* of the matrix using Gauss-Jordan elimination on the matrix. This will enable us to see how each $a_i$ variable relates to each other.

$$
\text{rref}\begin{bmatrix} 
1 & 0 & -6 & 0 & 0\\
2 & 1 & -6 & -2 & 0\\
0 & 2 & -12 & 0 & 0\\
0 & 0 & 0 & 0 & 0
\end{bmatrix} = \begin{bmatrix} 
1 & 0 & 0 & -1 & 0\\
0 & 1 & 0 & -1 & 0\\
0 & 0 & 1 & -0.166.. & 0\\
0 & 0 & 0 & 0 & 0
\end{bmatrix}
$$

Taking the *absolute value* of the second-to-last column and removing any zeroes, we can extract the following numbers:

$$
a_1=1, a_2=1, a_3=0.166.., a_4=?
$$

A very helpful helper function `Math.rationalApproximation(of: decimal)` in the `Tools` package of PocketChem (as discussed in the *Architecture* section) allows the program to approximate decimal numbers as fractions with a integer numerator and integer denominator. This converts the decimal in the answer into fractions which is nicer to work with:

$$
a_1=\frac{1}{1}, a_2=\frac{1}{1}, a_3=\frac{1}{6}, a_4=?
$$

From here, the program finds the least common multiple of all of the denominators, and multiplies all of the fractions by this. In addition, any remaining blank variables are replaced with the least common multiple.

$$
a_1=6, a_2=6, a_3=1, a_4=6
$$

If any of these fractions can be factored out and simplified, the program takes care of it in this step. Notice that these are the solved coefficients for the balanced chemical equation! The following then holds true:

$$
6CO_2+6H_2O \rightarrow C_6H_{12}O_6+6O_2
$$

In the final answer, there are *6 carbon*, *18 oxygen*, and *12 hydrogen* elements on both sides of the equation, proving that it is balanced.

This problem is a pretty nice use case for linear algebra, and a satisfying / grounded real-world example of how it can be used in apps and software engineering. Math was used in many of the other features of the app, including to solve empirical formulas and molecular formulas. 

### Chemistry Formula Parsing

All of the above functionality is powered by the `Tools` package's (as discussed in the *Architecture* section) `ChemistryParser` struct. This feature requires a bit of refactoring as its logic is still out of date (written when I was a high schooler - so I am sure there is a lot of room for improvement), however it enables the conversion of a string representation of a chemical equation into a mapping of elements to numbers. For example, glucose ($C_6H_{12}O_6$) represented as a string would be `"C6H12O6"`. Calling the parser on this string would result in:

```swift
let glucose = "C6H12O6"
ChemistryParser.elementsAndNumbersFromCompound(glucose)
// Produces:
// ["C" : 6, "H" : 12, "O": 6]
```

This allows for the easy creation of linear equations in the `ChemicalEquationBalancer` tool. This parser is also more sophistocated and has to run with parenthesis in mind. For example:

```swift
let ironIIISulfate = "Fe2(SO4)3"
ChemistryParser.elementsAndNumbersFromCompound(ironIIISulfate)
// Produces:
// ["Fe" : 2, "S" : 3, "O": 12]
```

*In the future, I plan on updating this parser to include learned lessons from college study of languages and compilers to support nested parenthesis (while rare, the functionality would be useful to include).*

## Final Thoughts

