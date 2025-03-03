<%@ include file="../common/header.jsp" %>

<div class="max-w-2xl mx-auto">
    <div class="card">
        <p><%=session.getAttribute("teacherId")%></p>
        <div class="bg-primary px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Add New Assignment</h2>
        </div>
        <div class="p-6">
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-danger/10 border border-danger text-danger px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/addAssignment" method="post" 
                  enctype="multipart/form-data" class="space-y-4">
                <input type="hidden" name="action" value="addAssignment">
                <div>
                    <label for="title" class="form-label">Title</label>
                    <input type="text" id="title" name="title" required
                           class="form-input" value="${title}">
                </div>
                
                <div>
                    <label for="description" class="form-label">Description</label>
                    <textarea id="description" name="description" required
                            class="form-input h-32">${description}</textarea>
                </div>
                
                <div>
                    <label for="targetClass" class="form-label">Target Class</label>
                    <select id="targetClass" name="targetClass" required class="form-input">
                        <option value="">Select Class</option>
                        <option value="A">Class A</option>
                        <option value="B">Class B</option>
                        <option value="C">Class C</option>
                        <option value="D">Class D</option>
                    </select>
                </div>
                
                <div>
                    <label for="deadline" class="form-label">Deadline</label>
                    <input type="date" id="deadline" name="deadline" required
                           class="form-input" value="${deadline}">
                </div>
                
                <div>
                    <label for="assignmentFile" class="form-label">Assignment File</label>
                    <input type="file" id="assignmentFile" name="assignmentFile"
                           class="form-input" accept=".pdf,.doc,.docx,.txt">
                    <p class="text-sm text-gray-500 mt-1">
                        Accepted formats: PDF, DOC, DOCX, TXT
                    </p>
                </div>
                
                <button type="submit" class="btn btn-primary w-full">
                    Add Assignment
                </button>
            </form>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>