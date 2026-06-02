<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Login Portal</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: #0f172a;
            color: #f8fafc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: #1e293b;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 1.5rem;
            color: #38bdf8;
        }

        .input-group {
            margin-bottom: 1.25rem;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: #94a3b8;
        }

        input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #334155;
            border-radius: 6px;
            background: #0f172a;
            color: #fff;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.2s;
        }

        input:focus {
            border-color: #38bdf8;
        }

        button {
            width: 100%;
            padding: 0.75rem;
            background: #0284c7;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 0.5rem;
        }

        button:hover {
            background: #0369a1;
        }

        #message {
            margin-top: 1rem;
            font-size: 0.95rem;
            min-height: 20px;
        }

        .success { color: #4ade80; }
        .error { color: #f87171; }
        
        .dashboard {
            display: none;
        }
    </style>
</head>
<body>

    <div class="login-container" id="loginBox">
        <h2>System Login</h2>
        <form id="loginForm" onsubmit="handleLogin(event)">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" required autocomplete="off">
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" required>
            </div>
            <button type="submit">Log In</button>
        </form>
        <p id="message"></p>
    </div>

    <div class="login-container dashboard" id="dashboardBox">
        <h2>Welcome back, Kuryente!</h2>
        <p style="color: #94a3b8; margin-bottom: 1.5rem;">You have successfully accessed the secure area.</p>
        <button onclick="handleLogout()" style="background: #dc2626;">Log Out</button>
    </div>

    <script>
        function handleLogin(event) {
            event.preventDefault(); // Prevents the page from refreshing
            
            const userInp = document.getElementById('username').value;
            const passInp = document.getElementById('password').value;
            const msg = document.getElementById('message');

            // EXACT MATCH CREDENTIALS
            if (userInp === "Kuryente" && passInp === "Admin") {
                msg.className = "success";
                msg.innerText = "Login successful! Redirecting...";
                
                setTimeout(() => {
                    // Hide login box, show dashboard
                    document.getElementById('loginBox').style.display = 'none';
                    document.getElementById('dashboardBox').style.display = 'block';
                    // Clear inputs for security
                    document.getElementById('loginForm').reset();
                    msg.innerText = "";
                }, 1000);

            } else {
                msg.className = "error";
                msg.innerText = "Invalid username or password.";
            }
        }

        function handleLogout() {
            // Return back to login view
            document.getElementById('dashboardBox').style.display = 'none';
            document.getElementById('loginBox').style.display = 'block';
        }
    </script>
</body>
</html>
