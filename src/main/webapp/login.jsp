<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>

	<%
		if (request.getParameter("submit")!= null){
			int id = 0;
			String password = null;
			try {
				id = Integer.parseInt(request.getParameter("id"));
				password = request.getParameter("password");
				
				Employee e = DbRepository.find(Employee.class, id);
				if (e.getPassword().equals(password)){
					session.setAttribute("login", e);
					response.sendRedirect("listCompany.jsp");
				} else {
					response.sendRedirect("login.jsp");
				}
			} catch (Exception e) {
				response.sendRedirect("error.jsp?msg=Se han introducido mal los datos");
			}
		}
	%>
<form>
  <!-- Email input -->
  <div class="form-outline mb-4">
    <input type="email" id="form2Example1" name="id" class="form-control" />
    <label class="form-label" for="form2Example1">Id</label>
  </div>

  <!-- Password input -->
  <div class="form-outline mb-4">
    <input type="password" id="form2Example2" name="password" class="form-control" />
    <label class="form-label" for="form2Example2">Password</label>
  </div>

  <!-- Submit button -->
  <button type="submit" name="submit" class="btn btn-primary btn-block mb-4">Sign in</button>

  <!-- Register buttons -->
  <div class="text-center">
    <p>Not a member? <a href="#!">Register</a></p>
  </div>
</form>
</body>
</html>