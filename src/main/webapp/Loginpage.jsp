<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPORTX</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/styles_Loginpage.css">
</head>

<body>
    <header>
        <section class="headerSportx">
            <h1>SPORTX</h1>
        </section>
    </header>

    <main>
        <section class="login-container">
            <h1>Login</h1>
            <p>Please login using account details below.</p>
            <form action="/html/index.html" method="GET">
                <label for="email">Email Address</label>
                <input type="email" name="email" required />

                <label for="password">Password</label>
                <input type="password" name="password" required />

                <label>Forgot your password?</label>

                <button type="submit">Sign In</button>
            </form>
            <p>Don't have an account? <a href="/html/Sign_up_Page.html">Create Account</a></p>
        </section>

        <section class="support">
            <h2>Support</h2>
            <ul>
                <li><a href="ContactUs.jsp">Contact us</a></li>
                <li><a href="FAQ.jsp">FAQ</a></li>
            </ul>
        </section>

        <section class="subscribe">
            <h2>Subscribe for latest updates</h2>
            <form action="/subscribe">
                <input type="email" name="email" placeholder="Enter your email" required />
                <button type="submit">Subscribe</button>
            </form>
        </section>
    </main>
</body>

</html>