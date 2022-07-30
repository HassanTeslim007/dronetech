# Drone Tech

## Project Structure
- Project Entry at main.dart
- Seperate foler for Ui and Model - with services and abstractions where necessary.
- Ui include App's physical components - Screens, Widgets and DialogBoxes - would include others like bottomsheets where applicable
- Each screen and dialogbox has a seperate folder with their respecgtive View and Logic files
- App contains ephemeral states and therefore employs Stateful widget (setState((){})) and streams to update UI