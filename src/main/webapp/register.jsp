<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.model.Company"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
<% 
	ArrayList<Company> companys = null;
	if (request.getParameter("register") != null) {
		String name = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String sex = request.getParameter("sex");
		Date date = Date.valueOf(request.getParameter("date"));
		int idCompany = Integer.parseInt(request.getParameter("company"));
		Company c = DbRepository.find(Company.class, idCompany);
		String password = DigestUtils.md5Hex(request.getParameter("password"));
		String confirmPassword = DigestUtils.md5Hex(request.getParameter("confirmPassword"));
		String rol = "USER";
		
		if (password.equals(confirmPassword)){
		Employee e = new Employee(name, lastName, email, sex, date, password, rol, c);
		DbRepository.add(Employee.class, e);
		response.sendRedirect("login.jsp");
			
		}
		
	} else {
		companys = (ArrayList<Company>) DbRepository.findAll(Company.class);
	}
%>
<form>
	<label class="form-label">Nombre</label>
	<input name="firstName" type="text" class="form-control">
	
	<label class="form-label">Apellidos</label>
	<input name="lastName" type="text" class="form-control">
	
	<label class="form-label">Email</label>
	<input name="email" type="email" class="form-control">
	
	<label class="form-label">Password</label>
	<input name="password" type="password" class="form-control">
	
	<label class="form-label">Confirm Password</label>
	<input name="confirmPassword" type="password" class="form-control">
	
	<label class="form-label">Sex</label>
	<input value="male" type="radio" name="sex"><label>Hombre</label>
	<input value="female" type="radio" name="sex"><label>Mujer</label>
	
	<label class="form-label">Date of Birth</label> 
	<input name="date" type="date" class="form-control">
	
	<label for="exampleInputPassword1" class="form-label">Company</label>
	<select name="company" class="form-select">
				<%
				for (Company c : companys) {
				%>
				<option value="<%=c.getId()%>"><%=c.getName()%></option>
				<%
				}
				%>
	</select>
	<button name="register" type="submit" class="btn btn-primary">Register</button>
</form>
</body>
</html>