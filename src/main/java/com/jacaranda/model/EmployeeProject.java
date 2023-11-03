package com.jacaranda.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="employeeProject")
public class EmployeeProject {
	
	@Id
	private int idEmployee;
	
	@Id
	private int idProject;
	
	private int minutes;
}
