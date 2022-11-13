# Ranked

This project is the Software Engineering Capstone Project for me, Valentin Silvera 👋
It's a native iOS app that allows people to quickly create polls and vote on them, using a ranked-voting system. Here you rank the options in order of preference. More information about the counting system [here](https://en.wikipedia.org/wiki/Instant-runoff_voting).

This document aims to give an short overview about the techstack. The complete Technical Document is available [here](docs/docs.pdf).
Most importantly, the reader gets to know how to install and run the project locally.

### Demo Video of the project

[Available on YouTube.](https://www.youtube.com/watch?v=_S8tDS7wRCE)

### The algorithm
All the documentation was done inline [here](./ranked/ranked/Algorithm/Count.swift), when using it you can just Opt+click any methods, or variables to get all the information.


### Installation

You can start by cloning the repo to your own machine:
```zsh
git clone git@github.com:valentinsilvera/ranked.git
cd ranked
```

Note that in order to run ranked locally on your own device you need to change the signing certificate for Xcode development and creating your own firestore database (the api calls will make sure to create all the collections and documents, so you can create an empty one):
- Open the project in Xcode
- Select "ranked" on the side panel
- Select the "ranked" target
- In the "Signing and Capabilities" tab select your own team and rename the bundle identifier to "com.YOURTEAMNAME.ranked"
- Create a project on firebase firestore with the new bundle identifier
- Download the "GoogleService-Info.plist" and move it to the root directory of the project

# Techstack 

The entire project has been written using Swift:
- [Swift](https://github.com/apple/swift)

The authentication and database were done with Firebase:
- [Firebase](https://github.com/firebase/)

The UI has been written in SwiftUI without any other libraries.

# DB Model

![Schema](./docs/schema.png?raw=true)

### Author
🧑‍💻 Valentin Silvera - [@ValentinSilvera](https://github.com/valentinsilvera)
