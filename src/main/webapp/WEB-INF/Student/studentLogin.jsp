<%@ include file="../common/header.jsp" %>

<div class="max-w-md mx-auto">
    <div class="card">
        <div class="bg-primary px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Student Login</h2>
        </div>
        <div class="p-6">
            <% if (request.getParameter("error") != null) { %>
                <div class="bg-danger/10 border border-danger text-danger px-4 py-3 rounded mb-4">
                    Invalid email or password
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/studentLogin" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="space-y-4">
                    <div>
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" required
                               class="form-input">
                    </div>
                    
                    <div>
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" required
                               class="form-input">
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-full">
                        Login
                    </button>
                </div>
            </form>
            
            <div class="mt-4 text-center">
                <p class="text-gray-600">
                    Don't have an account? 
                    <a href="${pageContext.request.contextPath}/studentRegistration" 
                       class="text-primary hover:text-blue-700">Register here</a>
                </p>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %> 