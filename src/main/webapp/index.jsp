<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>GreenSense</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="hero-container" id="heroContainer">
        <div class="hero-slide active" style="background-image: url('https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?q=80&w=2070&auto=format&fit=crop');"></div>
        <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1599664234221-399c71f3a2b7?q=80&w=2070&auto=format&fit=crop');"></div>
        <div class="hero-slide" style="background-image: url('https://images.unsplash.com/photo-1628177207936-21503a78925c?q=80&w=2070&auto=format&fit=crop');"></div>
        <div class="hero-content">
            <h1>A Smarter Approach to a Cleaner City</h1>
            <p>Report issues, track collections, and view waste analytics in real-time.</p>
            <div class="mt-4">
                <button class="btn" id="reportBtn"><i class="bi bi-geo-alt-fill me-2"></i>Report an Issue</button>
            </div>
        </div>
    </div>

    <div class="container py-5">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm p-3">
                    <i class="bi bi-telephone-inbound-fill feature-icon mb-2"></i>
                    <h5>Report & Complain</h5>
                    <p>Instantly report garbage spots with geotagged photos using your phone.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm p-3">
                    <i class="bi bi-truck-front-fill feature-icon mb-2"></i>
                    <h5>Live Tracking</h5>
                    <p>Admins can monitor garbage trucks in real-time for efficient route management.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm p-3">
                    <i class="bi bi-pie-chart-fill feature-icon mb-2"></i>
                    <h5>Data Analytics</h5>
                    <p>View interactive dashboards on waste composition and recycling efforts.</p>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />

    <%-- Registration Overlay --%>
    <div class="overlay" id="registerOverlay">
        <div class="auth-box">
            <span class="close-btn" id="closeRegisterBtn">&times;</span>
            <h3>Create GreenSense Account</h3>
            <form action="${pageContext.request.contextPath}/register" method="post">
                <input type="text" class="form-control" name="fullName" placeholder="Full Name" required>
                <input type="email" class="form-control" name="email" placeholder="Email Address" required>
                <div class="password-container" style="margin-bottom: 15px;">
                     <input type="password" class="form-control" name="password" id="registerPassword" placeholder="Create Password" required>
                     <span class="toggle-password" onclick="togglePasswordVisibility('registerPassword')" style="top: 12px; color: var(--muted);">👁️</span>
                </div>
                <input type="hidden" name="role" value="citizen">
                <button type="submit" class="btn-auth">Register</button>
            </form>
            <p class="text-center mt-3 small">
                Already have an account? <a href="#" class="switch-form" id="switchToLogin">Login</a>
            </p>
        </div>
    </div>

    <%-- Login Overlay --%>
    <div class="overlay" id="loginOverlay">
        <div class="auth-box">
            <span class="close-btn" id="closeLoginBtn">&times;</span>
            <h3>Welcome Back</h3>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="email" class="form-control" name="email" placeholder="Email Address" required>
                <div class="password-container" style="margin-bottom: 15px;">
                    <input type="password" class="form-control" name="password" id="loginPassword" placeholder="Password" required>
                    <span class="toggle-password" onclick="togglePasswordVisibility('loginPassword')" style="top: 12px; color: var(--muted);">👁️</span>
                </div>
                <button type="submit" class="btn-auth">Login</button>
            </form>
            <p class="text-center mt-3 small">
                New user? <a href="#" class="switch-form" id="switchToRegister">Create an Account</a>
            </p>
        </div>
    </div>
    
    <%-- All JavaScript --%>
    <script>
        console.log("SCRIPT IS RUNNING!"); // Test message

        document.addEventListener('DOMContentLoaded', function() {
            console.log("DOM is loaded. Attaching events."); // Test message 2

            // Check URL parameters for login trigger
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('login') === 'true') {
                const loginOverlay = document.getElementById('loginOverlay');
                if (loginOverlay) {
                    loginOverlay.classList.add('active');
                }
            }

            // --- Hero Slider ---
            const slides = document.querySelectorAll('.hero-slide');
            let current = 0;
            const totalSlides = slides.length;
            if(totalSlides > 0) {
                 setInterval(() => {
                    const prev = current;
                    current = (current + 1) % totalSlides;
                    slides[prev].classList.remove('active');
                    slides[prev].classList.add('prev');
                    slides[current].classList.add('active');
                    setTimeout(() => slides[prev].classList.remove('prev'), 1000);
                }, 5000);
            }

            // --- Overlay Logic ---
            const registerOverlay = document.getElementById('registerOverlay');
            const loginOverlay = document.getElementById('loginOverlay');
            const openRegisterBtn = document.getElementById('openRegisterBtn');
            const closeRegisterBtn = document.getElementById('closeRegisterBtn');
            const switchToLogin = document.getElementById('switchToLogin');
            const openLoginBtn = document.getElementById('openLoginBtn');
            const closeLoginBtn = document.getElementById('closeLoginBtn');
            const switchToRegister = document.getElementById('switchToRegister');
            const reportBtn = document.getElementById('reportBtn');

            const openRegister = (e) => { if(e) e.preventDefault(); registerOverlay.classList.add('active'); };
            const closeRegister = () => registerOverlay.classList.remove('active');
            const openLogin = (e) => { if(e) e.preventDefault(); loginOverlay.classList.add('active'); };
            const closeLogin = () => loginOverlay.classList.remove('active');

            if (openRegisterBtn) openRegisterBtn.addEventListener('click', openRegister);
            if (reportBtn) reportBtn.addEventListener('click', openLogin);
            if (closeRegisterBtn) closeRegisterBtn.addEventListener('click', closeRegister);

            if (openLoginBtn) openLoginBtn.addEventListener('click', openLogin);
            if (closeLoginBtn) closeLoginBtn.addEventListener('click', closeLogin);

            if (switchToLogin) switchToLogin.addEventListener('click', (e) => { e.preventDefault(); closeRegister(); openLogin(e); });
            if (switchToRegister) switchToRegister.addEventListener('click', (e) => { e.preventDefault(); closeLogin(); openRegister(e); });

            if (registerOverlay) registerOverlay.addEventListener('click', e => { if (e.target === registerOverlay) closeRegister(); });
            if (loginOverlay) loginOverlay.addEventListener('click', e => { if (e.target === loginOverlay) closeLogin(); });
        });

        // --- Password Toggle Function ---
        function togglePasswordVisibility(inputId) {
            const passwordInput = document.getElementById(inputId);
            const toggleIcon = passwordInput.nextElementSibling;
            
            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                toggleIcon.textContent = "🙈";
            } else {
                passwordInput.type = "password";
                toggleIcon.textContent = "👁️";
            }
        }
    </script>
</body>
</html>