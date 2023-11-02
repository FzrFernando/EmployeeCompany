<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Employee</title>
</head>
<body>
<%
if(session.getAttribute("login")==null){
	response.sendRedirect("error.jsp?msg=Tienes que iniciar sesión");
	return;
}
	if(request.getParameter("del")!=null){
		
		int idEmployee=0;
		
		try{
		idEmployee = Integer.parseInt(request.getParameter("id"));
		
		}catch(Exception exct){
			response.sendRedirect("error.jsp?msg=El id esta mal");
			return;
		}
		
		
		Employee e = null;
		try{
			e = DbRepository.find(Employee.class, idEmployee);
		}catch(Exception ext){
			response.sendRedirect("error.jsp?msg=El empleado no existe");
			return;
		}
		DbRepository.delete(Employee.class, e);
		
		response.sendRedirect("listEmployee.jsp");
		
	}else{
		
		Employee e=null;
		try{
		int idEmployee = Integer.parseInt(request.getParameter("id"));
		e = DbRepository.find(Employee.class, idEmployee);
		}catch(Exception exct){
			response.sendRedirect("error.jsp?msg=El empleado no existe");
			return;
		}	
	%>
	<form>
		<input value="<%=e.getId()%>" name="id" type="text" hidden="hidden">
		<label>Nombre</label>
		<input readonly="readonly" value="<%=e.getFirstName()%>" name="firstName" type="text">
		
		<label>Apellido</label>
		<input readonly="readonly" value="<%=e.getLastName()%>" name="lastName" type="text">
		
		<label>Email</label>
		<input readonly="readonly" value="<%=e.getEmail()%>" name="email" type="email">

		<label>Sexo</label>
		<select name="gender">
				<%if(e.getGender().equals("Male")){ %>
				<option value="Male">Hombre</option>
				
				<%}else{ %>
				
				<option value="Female">Mujer</option>
				<%} %>
			</select>
		
		<label>Fecha nacimiento</label>
		<input readonly="readonly" value="<%=e.getDateOfBirth() %>" name="date" type="date">
		
		<label>Compañia</label>
		<select name="company">
			<option selected="selected" value="<%=e.getCompany().getName() %>"><%=e.getCompany().getName() %></option>
		</select>
		<button name="del" type="submit">Delete</button>
	</form>
	<%} %>
</body>
</html>