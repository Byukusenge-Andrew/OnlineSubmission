<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignment Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .container{
            margin: auto;
            width: 90%;
           max-width: 12000px;
        }
        .hero {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: black;
            padding: 6rem 2rem;
            text-align: center;
            border-radius: var(--border-radius);
            margin-bottom: 3rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&q=80') center/cover;
            opacity: 0.1;
            z-index: 0;
        }

        .hero * {
            position: relative;
            z-index: 1;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .hero p {
            font-size: 1.4rem;
            opacity: 0.95;
            max-width: 700px;
            margin: 0 auto 2rem;
            line-height: 1.6;
        }

        .portal-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2.5rem;
            margin-bottom: 4rem;
        }

        .card {
            background: white;
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        .card h2 {
            font-size: 1.8rem;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .card p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .button {
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            background: #00f2fe;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2.5rem;
            text-align: center;
            margin-bottom: 4rem;
        }

        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            color: var(--primary);
            transition: transform 0.3s ease;
        }

        .card:hover .feature-icon {
            transform: scale(1.1);
        }

        .features .card h3 {
            font-size: 1.4rem;
            margin-bottom: 1rem;
            color: #333;
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }
            
            .hero p {
                font-size: 1.2rem;
            }
            
            .portal-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <section class="hero">
            <h1>Welcome to Assignment Portal</h1>
            <p>A modern platform for managing and submitting assignments</p>
        </section>

        <div class="portal-cards">
            <div class="card">
                <h2>Teacher Portal</h2>
                <p>Create and manage assignments, track submissions</p>
                <div style="margin-top: 1.5rem;">
                    <a href="teacherLogin" class="button">Login</a>
                    <a href="teacherRegistration" class="button" style="margin-left: 1rem;">Register</a>
                </div>
            </div>

            <div class="card">
                <h2>Student Portal</h2>
                <p>View and submit assignments, track your progress</p>
                <div style="margin-top: 1.5rem;">
                    <a href="studentLogin" class="button">Login</a>
                    <a href="studentRegistration" class="button" style="margin-left: 1rem;">Register</a>
                </div>
            </div>
        </div>

        <section class="features">
            <div class="card">
                <div class="feature-icon">📚</div>
                <h3>Easy Management</h3>
                <p>Organize and track assignments efficiently</p>
            </div>
            <div class="card">
                <div class="feature-icon">⏰</div>
                <h3>Deadline Tracking</h3>
                <p>Never miss important submission dates</p>
            </div>
            <div class="card">
                <div class="feature-icon">📊</div>
                <h3>Progress Monitoring</h3>
                <p>Track your academic performance</p>
            </div>
        </section>
    </div>
</body>
</html>
