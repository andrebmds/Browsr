BrowsrApp

BrowsrApp is a simple iOS application that allows users to search for Github organizations and save their favorite organizations. The project is built using the MVVM architectural pattern and uses CoreData to persist user data.

Project Structure

The project consists of two main components: BrowsrApp and BrowsrLib.

BrowsrApp is the main application target that contains the user interface and the view models. The user interface is developed programmatically using Auto Layout constraints. BrowsrApp uses BrowsrLib as a dependency to fetch data from the Github API.

BrowsrLib is a Swift package that contains the network layer and the models for the Github API. The network layer is responsible for making API requests and parsing the response data into Swift models. The library also includes a set of unit tests to ensure that the library code works as expected.

The project also includes a Utils folder that contains a Reachability class to handle network status. The FavoriteOrganizationsManager class in the CoreData folder is responsible for managing the user's favorite organizations using CoreData.

Architecture

The project is built using the Model-View-ViewModel (MVVM) architecture. The model layer is implemented using the Swift models from BrowsrLib. The view layer is implemented using the view controllers and views in BrowsrApp. The view models in BrowsrApp act as the glue between the model and view layers.

Features

BrowsrApp currently supports the following features:

Search Github organizations
Display search results in a table view
View organization details
Add/remove organizations to/from favorites
Display a warning message to the user if there is no internet connection
Requirements

BrowsrApp requires iOS 14.0 or later.

Installation

To install BrowsrApp, clone the repository and open BrowsrApp.xcodeproj.

bash
Copy code
git clone https://github.com/<username>/browsr-app.git
cd browsr-app
open BrowsrApp.xcodeproj
Credits

BrowsrApp was created by André Bortoli.
