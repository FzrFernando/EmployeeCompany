<%@page import="com.jacaranda.model.Users"%>
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
			String username = null, password = null;
			try{
				// Guardamos en variables el nombre y contraseña del usuario
				username = request.getParameter("username");
				password = request.getParameter("password");
				
				Users u = DbRepository.findString(Users.class, username);
				if (u.getPassword().equals(password)){
					session.setAttribute("login", u);
					response.sendRedirect("listCompany.jsp");
				} else {
					
				}
			} catch (Exception e) {
				response.sendRedirect("error.jsp?msg=El usuario o contraseña están mal");
				return;
			}
		}
	%>
<form>
  <!-- Email input -->
  <div class="form-outline mb-4">
    <input type="email" id="form2Example1" name="username" class="form-control" />
    <label class="form-label" for="form2Example1">Email address</label>
  </div>

  <!-- Password input -->
  <div class="form-outline mb-4">
    <input type="password" id="form2Example2" name="password" class="form-control" />
    <label class="form-label" for="form2Example2">Password</label>
  </div>

  <!-- 2 column grid layout for inline styling -->
  <div class="row mb-4">
    <div class="col d-flex justify-content-center">
      <!-- Checkbox -->
      <div class="form-check">
        <input class="form-check-input" type="checkbox" value="" id="form2Example31" checked />
        <label class="form-check-label" for="form2Example31"> Remember me </label>
      </div>
    </div>

    <div class="col">
      <!-- Simple link -->
      <a href="#!">Forgot password?</a>
    </div>
  </div>

  <!-- Submit button -->
  <button type="button" name="submit" class="btn btn-primary btn-block mb-4">Sign in</button>

  <!-- Register buttons -->
  <div class="text-center">
    <p>Not a member? <a href="#!">Register</a></p>
  </div>
</form>
</body>
</html>