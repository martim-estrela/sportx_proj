<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SPORTX</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/styles_SignupPage.css">
</head>

<body>
    <header>
        <section class="headerSportx">
            <h1>SPORTX</h1>
        </section>
    </header>

    <main>
        <section class="SignUp-container">
            <h1>Sign Up</h1>
            <p>Please Complete all required fields.</p>
            <form action="Loginpage.jsp" method="GET">
                <label for="username">Enter Username</label>
                <input type="username" name="username" required />

                <label for="email">Enter Email Address</label>
                <input type="email" name="email" required />

                <label for="phonenumber">Enter Phone Number</label>
                <input type="phonenumber" name="phonenumber" required />

                <label for="password">Enter Password</label>
                <input type="password" name="password" required />

                <button type="submit">Sign Up</button>
            </form>
            <p>Already have an Account? <a href="/html/Loginpage.html">Login</a></p>
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