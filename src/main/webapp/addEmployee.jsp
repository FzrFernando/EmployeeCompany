<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Employee</title>
</head>
<body>
<%
if(request.getParameter("add")!=null){
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String gender = request.getParameter("gender");
	SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");
	Date date = formatter.parse(request.getParameter("date"));
	int idCompany = Integer.parseInt(request.getParameter("company"));
	Company c = DbRepository.find(Company.class, idCompany);
	Employee e = new Employee(firstName,lastName,email,gender,date,c);
	
	DbRepository.add(Employee.class, e);

			%>
<%
}else{
	ArrayList<Company> result = null;
	try{
		result =(ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception e){
		
	}
	%>
	<form method="post">
				<label>Name</label>
				<input name="firstName" type="text">
			
				<label>Last Name</label>
				<input name="lastName" type="text">

				<label>Email</label>
				<input name="email" type="email">

			<label>Sex</label>
			<select name="gender">
				<option value="Male">Male</option>
				<option value="Female">Female</option>
			</select>

				<label>Date Of Birth</label>
				<input name="date" type="date">

			<label>Company</label>
			<select name="company">
			<%
				for(Company c : result){
			%>
			<option value="<%=c.getId()%>"><%=c.getName() %></option>
			<%
				}
			%>
			</select>
			
			<button name="add" type="submit">Add</button>
		</form>
<%} %>
</body>
</html>