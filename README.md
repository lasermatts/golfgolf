# GolfGolf: Your Digital Scorecard

## Overview

GolfGolf is a mobile application designed to enhance the golfing experience by providing a digital scorecard for both iOS and Apple Watch. The app allows users to easily track their scores while playing golf, leveraging the convenience of their Apple Watch or iPhone to keep track without the need for traditional pen and paper.


### Key Features

- **Start Game Configuration**: Users can set up their game by selecting the type of golf (Ball or Disc), number of holes (9 or 18), and par configuration (Standard or Custom).

![GolfGolf's configuration view on the Apple Watch](https://github.com/lasermatts/golfgolf/blob/main/reference_pics/watch_setup_may6.png)

- **Real-time Scoring**: On the Apple Watch, users can increment or decrement their stroke count with a simple tap, view their total score, and move between holes seamlessly.

![GolfGolf's score snapshot view on the Apple Watch](https://github.com/lasermatts/golfgolf/blob/main/reference_pics/watch_snapshot_may6.png)
- **Finish Game Review**: At the end of a round, users can send their total scores, along with other game metrics, directly to their iPhone for more detailed viewing and analysis.

![Finished game as seen on the Apple Watch while transferring data to your iPhone](https://github.com/lasermatts/golfgolf/blob/main/reference_pics/watch_finished_may6.png)

- **Statistics View**: Post-game, users can view detailed statistics on their iPhone, including total score, game duration, and specific scores per hole.

## Design Strategy

The design philosophy behind GolfGolf focuses on simplicity and efficiency, catering to the needs of golfers who want to focus on their game without unnecessary distractions. High-contrast UI elements ensure readability in various lighting conditions, crucial for outdoor use. The user interface is optimized for ease of use, allowing golfers to track their game with minimal interaction.

### Color Scheme

- **Primary Colors**: Dark blue and white, ensuring high readability under direct sunlight.
- **Accent Colors**: Bright greens and vibrant blues to denote interactive elements like buttons.

## Upcoming Work

- **Advanced Statistics**: Future versions will include advanced metrics such as average strokes per hole, recommendations for game improvement, and historical data comparison.
- **Social Features**: We plan to introduce capabilities to connect with friends, compare scores, and even arrange future golf games through the app.
- **Enhanced Customization**: Options for users to personalize UI elements and configure more detailed aspects of their games.
- **Health Integration**: Leveraging the Apple HealthKit to include health data from the game duration such as steps taken and calories burned.

## Technologies Used

- **SwiftUI**: For building a robust and responsive UI across iOS and watchOS.
- **WatchConnectivity**: To manage communication between the iOS and watchOS applications.
- **WidgetKit**: To provide quick access to the app via widgets that can be added to the watch face.

