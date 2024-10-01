Here's a comprehensive summary of important Flutter widgets, categorized based on their roles, with detailed tables outlining key properties and events for each widget.

### **1. Layout Widgets**

#### **Container**

A flexible widget used to style and position its child.

| **Property**       | **Description**                                                |
| ------------------ | -------------------------------------------------------------- |
| `padding`          | Adds padding inside the container around the child widget.     |
| `margin`           | Adds space around the outside of the container.                |
| `color`            | Sets the background color of the container.                    |
| `decoration`       | Allows customization such as borders, gradients, shadows, etc. |
| `alignment`        | Aligns the child within the container.                         |
| `width` / `height` | Sets the width and height of the container.                    |

| **Event** | **Description**                                                        |
| --------- | ---------------------------------------------------------------------- |
| `onTap`   | Triggers when the container is tapped (usually via `GestureDetector`). |

#### **Row / Column**

Arranges child widgets horizontally (`Row`) or vertically (`Column`).

| **Property**         | **Description**                                                                    |
| -------------------- | ---------------------------------------------------------------------------------- |
| `mainAxisAlignment`  | Aligns children along the main axis (horizontal for `Row`, vertical for `Column`). |
| `crossAxisAlignment` | Aligns children along the cross axis.                                              |
| `children`           | List of widgets to display inside the `Row` or `Column`.                           |
| `mainAxisSize`       | Determines the size of the main axis. (`MainAxisSize.max` or `MainAxisSize.min`)   |

| **Event** | **Description**                                                                                     |
| --------- | --------------------------------------------------------------------------------------------------- |
| N/A       | Row and Column don’t have inherent interactive events. Events can be added using `GestureDetector`. |

#### **Stack**

Allows widgets to be layered on top of each other.

| **Property** | **Description**                                                                                  |
| ------------ | ------------------------------------------------------------------------------------------------ |
| `alignment`  | Aligns children within the stack.                                                                |
| `fit`        | Determines how the children are resized to fill the stack. (`StackFit.loose`, `StackFit.expand`) |
| `overflow`   | Handles overflow of children beyond the stack’s bounds.                                          |
| `children`   | List of widgets to be layered.                                                                   |

| **Event** | **Description**                                                                  |
| --------- | -------------------------------------------------------------------------------- |
| N/A       | Stack doesn't have inherent events, but `GestureDetector` can add interactivity. |

#### **ListView**

Displays a scrollable list of widgets.

| **Property**      | **Description**                                        |
| ----------------- | ------------------------------------------------------ |
| `children`        | List of widgets in the scrollable list.                |
| `scrollDirection` | Sets the direction of scrolling (horizontal/vertical). |
| `itemBuilder`     | Builds items on demand for efficiency.                 |
| `itemCount`       | Sets the total number of items in the list.            |
| `padding`         | Adds padding around the list items.                    |

| **Event**  | **Description**                                 |
| ---------- | ----------------------------------------------- |
| `onScroll` | Detects when the user scrolls through the list. |

---

### **2. Input Widgets**

#### **TextField**

A basic text input field.

| **Property**   | **Description**                                                     |
| -------------- | ------------------------------------------------------------------- |
| `controller`   | Controls the text being edited.                                     |
| `decoration`   | Adds decoration (like label, border, hint text) to the input field. |
| `keyboardType` | Specifies the type of keyboard to display (e.g., text, number).     |
| `maxLength`    | Limits the number of characters allowed in the input.               |
| `obscureText`  | Hides the text input (used for passwords).                          |

| **Event**           | **Description**                                                  |
| ------------------- | ---------------------------------------------------------------- |
| `onChanged`         | Triggers whenever the input value changes.                       |
| `onSubmitted`       | Triggers when the user submits the input (e.g., pressing enter). |
| `onTap`             | Detects when the text field is tapped.                           |
| `onEditingComplete` | Fired when editing is finished (without submitting).             |

#### **Checkbox**

Displays a checkbox with two states: checked or unchecked.

| **Property**  | **Description**                                  |
| ------------- | ------------------------------------------------ |
| `value`       | Whether the checkbox is checked or not.          |
| `onChanged`   | Callback when the state of the checkbox changes. |
| `activeColor` | Sets the color when the checkbox is active.      |

| **Event**   | **Description**                           |
| ----------- | ----------------------------------------- |
| `onChanged` | Fires when the checkbox value is toggled. |

---

### **3. Button Widgets**

#### **ElevatedButton**

A button with elevation that elevates when pressed.

| **Property** | **Description**                                                       |
| ------------ | --------------------------------------------------------------------- |
| `onPressed`  | The function to execute when the button is pressed.                   |
| `style`      | Allows customization of the button's appearance (e.g., color, shape). |
| `child`      | The content inside the button (usually `Text` or `Icon`).             |

| **Event**   | **Description**                  |
| ----------- | -------------------------------- |
| `onPressed` | Fired when the button is tapped. |

#### **TextButton**

A simple text-based button without elevation.

| **Property** | **Description**                                     |
| ------------ | --------------------------------------------------- |
| `onPressed`  | The function to execute when the button is pressed. |
| `style`      | Allows customization of the button's appearance.    |
| `child`      | The content inside the button (usually `Text`).     |

| **Event**   | **Description**                      |
| ----------- | ------------------------------------ |
| `onPressed` | Triggered when the button is tapped. |

---

### **4. Display Widgets**

#### **Text**

Displays a string of text.

| **Property** | **Description**                                                  |
| ------------ | ---------------------------------------------------------------- |
| `data`       | The string to be displayed.                                      |
| `style`      | Defines the appearance of the text (e.g., font size, color).     |
| `textAlign`  | Aligns the text within its container.                            |
| `overflow`   | Controls what happens if the text is too long for its container. |

| **Event** | **Description** |
| N/A | Text is a static widget without events. |

#### **Image**

Displays images from various sources.

| **Property**       | **Description**                                                        |
| ------------------ | ---------------------------------------------------------------------- |
| `image`            | The source of the image (e.g., network, asset).                        |
| `fit`              | Defines how the image should fit its container (e.g., `BoxFit.cover`). |
| `width` / `height` | Specifies the size of the image.                                       |

| **Event** | **Description** |
| N/A | Image does not have inherent events. |

---

### **5. Navigation Widgets**

#### **Navigator**

Manages a stack-based navigation history.

| **Property**   | **Description**                    |
| -------------- | ---------------------------------- |
| `initialRoute` | Defines the initial route to load. |

| **Event** | **Description** |
| `push` | Navigates to a new screen by pushing it to the stack. |
| `pop` | Removes the top-most route from the stack. |
| `pushReplacement` | Replaces the current route with a new one. |
| `pushNamed` | Navigates to a route defined by a name. |

---

### **6. Interaction & Gesture Widgets**

#### **GestureDetector**

Detects various gestures like taps, drags, swipes, etc.

| **Property**       | **Description**                               |
| ------------------ | --------------------------------------------- |
| `onTap`            | Callback when the widget is tapped.           |
| `onDoubleTap`      | Detects a double-tap gesture.                 |
| `onLongPress`      | Triggers when a long press is detected.       |
| `onPanUpdate`      | Fires when a pan/drag gesture is in progress. |
| `onHorizontalDrag` | Detects horizontal drag gestures.             |

---

### **7. Animation Widgets**

#### **AnimatedContainer**

Automatically animates changes to its properties.

| **Property**       | **Description**                                        |
| ------------------ | ------------------------------------------------------ |
| `duration`         | Duration of the animation.                             |
| `curve`            | Defines the animation's curve (e.g., linear, ease-in). |
| `width` / `height` | Changes to the container's size are animated.          |
| `color`            | Color changes are animated.                            |

| **Event** | **Description** |
| N/A | The animation is managed internally based on property changes. |

### **8. Miscellaneous Widgets**

#### **Scaffold**

The basic structure of a screen, including app bars, drawers, and body content.

| **Property**           | **Description**                                          |
| ---------------------- | -------------------------------------------------------- |
| `appBar`               | Adds an `AppBar` widget at the top of the screen.        |
| `body`                 | The primary content of the screen.                       |
| `floatingActionButton` | A floating action button for performing primary actions. |
| `drawer`               | A slide-in menu from the side of the screen.             |
| `bottomNavigationBar`  | A navigation bar at the bottom of the screen.            |

| **Event**            | **Description**                               |
| -------------------- | --------------------------------------------- |
| `onDrawerChanged`    | Fires when the drawer is opened or closed.    |
| `onEndDrawerChanged` | Fires when an end drawer is opened or closed. |

#### **AppBar**

A material design app bar, typically used within a `Scaffold`.

| **Property**      | **Description**                                                                     |
| ----------------- | ----------------------------------------------------------------------------------- |
| `title`           | The primary widget displayed in the center of the app bar, usually a `Text` widget. |
| `actions`         | A list of widgets (usually icons) displayed on the right side of the app bar.       |
| `backgroundColor` | Sets the background color of the app bar.                                           |
| `elevation`       | Sets the z-coordinate at which the app bar is displayed.                            |

| **Event** | **Description** |
| N/A | AppBar does not have inherent events but can trigger events via widgets in `actions`. |

#### **SafeArea**

Ensures that its child widget is not obscured by system status bars, navigation bars, or notches.

| **Property**                | **Description**                                                               |
| --------------------------- | ----------------------------------------------------------------------------- |
| `child`                     | The widget to be displayed within the safe area.                              |
| `minimum`                   | Sets the minimum padding to ensure the widget is safe from system intrusions. |
| `maintainBottomViewPadding` | Ensures padding at the bottom even if the system does not require it.         |

| **Event** | **Description** |
| N/A | SafeArea doesn’t have inherent events. |

#### **Form**

A container for grouping and validating multiple form fields (e.g., `TextFormField`).

| **Property**       | **Description**                                                                       |
| ------------------ | ------------------------------------------------------------------------------------- |
| `child`            | The widget tree representing the form’s fields.                                       |
| `autovalidateMode` | Defines when the form fields should be validated (e.g., always, on user interaction). |
| `onChanged`        | Callback fired when any form field changes.                                           |

| **Event** | **Description** |
| `onChanged` | Triggers when the form data changes. |
| `onSaved` | Called when the form is saved (i.e., form submission). |

#### **Expanded**

A widget that expands to fill the available space in a `Row` or `Column`.

| **Property** | **Description**                                                                        |
| ------------ | -------------------------------------------------------------------------------------- |
| `child`      | The widget to be expanded.                                                             |
| `flex`       | The flex factor determining how much space this widget should take relative to others. |

| **Event** | **Description** |
| N/A | Expanded does not have inherent events. |

---

### Summary

This summary categorizes key Flutter widgets, explaining their functional roles along with tables detailing their properties and events. These widgets form the building blocks for Flutter applications, allowing developers to design complex, interactive, and responsive UIs. The properties and events listed here enable fine control over widget behavior and appearance, making Flutter a versatile framework for mobile, web, and desktop development.
