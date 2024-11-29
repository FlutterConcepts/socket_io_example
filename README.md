# Socket.IO Example

This repository demonstrates a simple **Flutter** project integrated with **Socket.IO** for real-time communication.

---

## 🚀 Getting Started

### Step 1: Clone the Repository

Open a terminal and run the following command:

```bash
git clone https://github.com/FlutterConcepts/socket_io_example.git
```

---

### Step 2: Navigate to the Project Directory

Move into the project folder:

```bash
cd socket_io_example
```

---

### Step 3: Open the Project in VS Code

If you use **Visual Studio Code**, open the project by running:

```bash
code .
```

---

### Step 4: Run Both Flutter Instances

Press **F5** in VS Code and select the **"Run Both Instances"** configuration.

⚠️ **Note:** You might notice the app isn’t fully functional yet. Proceed to the next steps to start the backend server and observe the real-time updates in the app.

---

## 🔧 Setting Up the Backend

### Step 1: Open the Backend Directory

In the terminal, navigate to the backend folder:

```bash
cd backend
```

---

### Step 2: Build and Run the Backend

Run the following command to build and start the backend using Docker:

```bash
docker-compose up --build
```

This will set up the backend server and make it ready to communicate with the Flutter apps.

---

## 🎉 Testing the Application

Once the backend is up and running:
1. Restart the Flutter app if needed.
2. Watch the app's state update automatically as it connects to the backend.

Now you’re all set to explore how **Socket.IO** works with Flutter! 🎨✨

---

## 🛠 Troubleshooting

- **Docker Issues:** Ensure Docker is installed and running on your machine. You can download it [here](https://www.docker.com/).
- **Flutter Errors:** Verify Flutter is properly installed and added to your system's PATH. Check with:
  ```bash
  flutter doctor
  ```
- **Socket.IO Connection:** If the app doesn’t connect, double-check the backend logs and ensure the `docker-compose` service is running without errors.

---

## 📂 Project Structure

- `lib/`: Contains the Flutter client code.
- `backend/`: Includes the backend configuration and code for real-time communication.

---

## 🤝 Contributions

Feel free to fork the repository, make improvements, and submit a pull request. Contributions are always welcome!

---

## 📜 License

This project is licensed under the **MIT License**. See the `LICENSE` file for more details.