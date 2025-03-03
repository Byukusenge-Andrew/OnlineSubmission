<%@ include file="common/header.jsp" %>

<div class="max-w-md mx-auto">
    <div class="card">
        <div class="bg-primary px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Student Registration</h2>
        </div>
        <div class="p-6">
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-danger/10 border border-danger text-danger px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/studentRegistration" method="post">
                <input type="hidden" name="action" value="register">
                
                <div class="space-y-4">
                    <div>
                        <label for="firstname" class="form-label">First Name</label>
                        <input type="text" id="firstname" name="firstname" 
                               value="${firstname}" required
                               class="form-input">
                    </div>
                    
                    <div>
                        <label for="lastname" class="form-label">Last Name</label>
                        <input type="text" id="lastname" name="lastname" 
                               value="${lastname}" required
                               class="form-input">
                    </div>
                    
                    <div>
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" 
                               value="${email}" required
                               class="form-input">
                    </div>
                    
                    <div>
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" required
                               class="form-input">
                        <p class="text-sm text-gray-500 mt-1">
                            Password must contain at least 8 characters, including uppercase, 
                            lowercase, number and special character.
                        </p>
                    </div>
                    
                    <div>
                        <label for="dob" class="form-label">Date of Birth</label>
                        <input type="date" id="dob" name="dob" 
                               value="${dob}" required
                               class="form-input">
                    </div>
                    
                    <div>
                        <label for="classroom" class="form-label">Classroom</label>
                        <select id="classroom" name="classroom" required
                                class="form-input">
                            <option value="">Select Classroom</option>
                            <option value="A" ${classroom == 'A' ? 'selected' : ''}>Class A</option>
                            <option value="B" ${classroom == 'B' ? 'selected' : ''}>Class B</option>
                            <option value="C" ${classroom == 'C' ? 'selected' : ''}>Class C</option>
                            <option value="D" ${classroom == 'D' ? 'selected' : ''}>Class D</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-full">
                        Register
                    </button>
                </div>
            </form>
            
            <div class="mt-4 text-center">
                <p class="text-gray-600">
                    Already have an account? 
                    <a href="${pageContext.request.contextPath}/studentLogin" 
                       class="text-primary hover:text-blue-700">Login here</a>
                </p>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
