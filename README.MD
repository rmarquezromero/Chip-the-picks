# Pick the chip game

Put n casino chips in a line. (Assume n is even and greater than 4). Two players take turns to take a chip from one of the ends of the line until there are no more chips left. The player with the larger amount of money wins.

  - Casino chips values are:  0.1, 0.2, 0.5, 1, 2, 5, 10 
  - Starting player is decided at random
  - Chips positions are decided at random
  - Players can tie if at the end of the game they have the same money
  - Illegal movements are not allowed
  - Cheat mode is available (awesome for cheaters)

### Version
1.0.0

### Tech

"Pick the chip" has been developed with STS IDE and works with:
* [Java] - Java 6 or higher
* [Tomcat] - Tomcat 7 or higher
* [Spring] 
* [Maven]
* [JUnit] 
* [jQuery] - 1.11.3 version is loaded on jsp.
* [HTML] 
* [CSS]
* [Google Chrome]

Internet connection is required.

### Installation

```sh
Open your Spring tool suite IDE
```
```sh
Import WAR file like Maven existing project
```
```sh
Select pom.xml and click finish
```
```sh
Execute "maven update project" with "Force Update of Snapshots/Releases" checked
```
```sh
Execute "clean install" on maven build option
```
```sh
Clean & build project
```
```sh
Run as > Run on server (on Tomcat Server)
```
```sh
Game is loaded on http://localhost:8080/springmvc/
```

