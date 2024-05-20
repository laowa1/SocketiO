# NewWebSocketApp

### Project Structure Description:

The project is structured using the MVP (Model-View-Presenter) architecture. Here's a brief description of each part:

* **Model**: Contains data and business logic. In this case, it is represented by the file `Item.swift`, which describes the data model.
* **View**: Responsible for displaying data and interacting with the user. These are the files `MainView.swift` and `MainViewController.swift`.
* **Presenter**: Handles user actions, interacts with the model, and updates the view. These are the files `MainPresenter.swift` and `MainPresenterProtocol.swift`.

### Report: Approach to Solving the Task and Problem-Solving

#### Approach to Solving the Task

1. **Requirement Analysis**:
    Studying the client's requirements and determining the main features to be implemented:
    * Connecting to the Socket.IO server.
    * Subscribing to events and processing real-time data.
    * Displaying data in a user-friendly interface.

2. **Architecture Selection**:
    For better separation of concerns and easier testing, the MVP (Model-View-Presenter) architecture was chosen.

3. **Development**:
    * **Model**: Creating the data model `Item`, which describes the structure of the received data.
    * **View**: Creating the user interface consisting of a `UITableView` for displaying data and buttons for connecting/disconnecting.
    * **Presenter**: Implementing the logic for connecting to Socket.IO, subscribing to events, and updating the view upon receiving data.

#### Problems and Solutions

1. **Problem**: Need to subscribe to events after connecting:
    * **Solution**: Include subscription to `csgo`, `add_item`, and `remove` events in the connect event handler.

2. **Problem**: Error in dependency injection:
    * **Solution**: Change the initialization order in `MainViewController` to first create the view, then initialize the presenter and pass the view as a dependency.

3. **Problem**: Displaying data in `UITableView`:
    * **Solution**: Ensure the table view is added to the view hierarchy and data is updated on the main thread. Use the `MainViewProtocol` to update the view from the presenter.

### Conclusion

The project was successfully implemented using the MVP architecture, which allowed for clear separation of responsibilities between components. All encountered problems were resolved, ensuring the correct operation of the application and a user-friendly interface for displaying real-time data.
