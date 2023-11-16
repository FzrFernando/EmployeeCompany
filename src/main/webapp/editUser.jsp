<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Información</title>
</head>
<body>
	<% 
	if(session.getAttribute("login")==null){
		response.sendRedirect("error.jsp?msg=Tienes que iniciar sesión");
		return;
	}
	Employee e = null;
	ArrayList<Company> company = null;
	
	
	if (request.getParameter("edit") != null ) {
		String firstName = null, lastName = null, email = null, gender = null, password = null;
		int idEmployee = 0, idCompany = 0;
		Date date = null;
		try {
			idEmployee = Integer.parseInt(request.getParameter("id"));
			e = DbRepository.find(Employee.class, idEmployee);
			firstName = request.getParameter("firstName");
			lastName = request.getParameter("lastName");
			email = request.getParameter("email");
			gender = request.getParameter("gender");
			password=request.getParameter("password");
			date = Date.valueOf(request.getParameter("date"));
			idCompany = Integer.parseInt(request.getParameter("company"));
		} catch (Exception exct) {
			response.sendRedirect("error.jsp?msg=Hay algun parametro en blanco");
			return;
		}
		Company c = DbRepository.find(Company.class, idCompany);
		e = new Employee(idEmployee, firstName, lastName, email, gender, date, e.getPassword(), e.getRole(), c);
		
		DbRepository.add(Employee.class, e);
		response.sendRedirect("listCompany.jsp");
		return;
	}
	%>
	
	<form>
		<input type="text" name="id" class="form-control" hidden value="<%=e.getId()%>">
		
		<div class="mb-3">
			<label class="form-label">Nombre</label> 
			<input type="text" name="firstName" class="form-control" value="<%=e.getFirstName()%>">
		</div>
		
		<div class="mb-3">
			<label class="form-label">Apellido</label> 
			<input type="text" name="lastName" class="form-control" value="<%=e.getLastName()%>">
		</div>
		
		<div class="mb-3">
			<label class="form-label">Password</label>
			<input type="password" id="password" name="password" class="form-control">
		</div>
		
		<div class="mb-3">
			<label class="form-label">Email</label> 
			<input type="email" class="form-control" name="email" value="<%=e.getEmail()%>" >
		</div>
		
		<div class="mb-3">
			<label class="form-label">Sexo</label>

			<%
			if (e.getGender().equals("Male")) {
			%>
			<div class="form-check">
				<input type="radio" checked="checked" class="form-check-input" value="Male"  name="gender"> 
				<label class="form-check-label">Hombre</label>
			</div>
			<div class="form-check">
				<input type="radio" class="form-check-input" value="Female" name="gender"> 
				<label class="form-check-label">Mujer</label>
			</div>
			<%
			} 
			else 
			{
			%>
			<div class="form-check">
				<input type="radio" class="form-check-input" value="Male" name="gender"> 
				<label class="form-check-label">Hombre</label>
			</div>
			<div class="form-check">
				<input type="radio" checked="checked" class="form-check-input" value="Female"  name="gender"> 
				<label class="form-check-label">Mujer</label>
			</div>
			<%
			}
			%>
		</div>
		
		<div class="mb-3">
			<label>Fecha nacimiento</label> 
			<input type="date" class="form-control" name="date" value="<%=e.getDateOfBirth()%>">
		</div>
		
		<div>
			<label class="form-label">Compañia</label> 
			<select class="form-select" name="company">
				<%
				for (Company c : company) {
					if (e.getCompany().getId() == c.getId()) {
				%>
				<option selected="selected" value="<%=c.getId()%>"><%=c.getName()%></option>
				<%
					} 
					else 
					{
				%>
				<option value="<%=c.getId()%>"><%=c.getName()%></option>
				<%
					}
				}
				%>
			</select>
		</div>
		
		<button  type="submit" class="btn btn-primary" name="edit">Editar</button>
	</form>
</body>
</html>