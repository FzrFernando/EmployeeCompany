package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.jacaranda.model.CompanyProject;
import com.jacaranda.model.EmployeeProject;
import com.jacaranda.utility.DbUtility;

public class DbRepository {

	public static <E> E find(Class<E> c, int id) throws Exception {
		Session session = null;
		E result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result = session.find(c,id);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <E> E findString(Class<E> c, String id) throws Exception {
		Session session = null;
		E result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result = session.find(c,id);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <E> List<E> findAll(Class<E> c) throws Exception {
		Session session = null;
		List<E> resultList = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			resultList = (List<E>) session.createSelectionQuery("From " + c.getName()).getResultList();
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return resultList;
	}
	
	public static <E> E add(Class<E> c, Object o) throws Exception{
		Transaction transaction = null;
		Session session = null;
		E result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		} 
		try {
			result = (E) session.merge(o);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
		}
		session.close();
		return result;
	}
	
	public static <E> E delete(Class <E>c, Object o) throws Exception{
		Transaction transaction = null;
		Session session = null;
		E result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		} 
		try {
			session.remove(o);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
		}
		session.close();
		return result;
	}
	
	public static void add(CompanyProject c) throws Exception {
		Transaction transaction = null;
		
		Session session = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			if(DbRepository.find(c)==null) {
				session.persist(c);
			}else {
				 session.merge(c);//persist para companyProject
			}
			
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
		}
		session.close();
	}
	
	public static CompanyProject find(CompanyProject cp) throws Exception {
		Session session = null;
		CompanyProject result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
			result =  session.find(CompanyProject.class, cp);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static void add(EmployeeProject c) throws Exception {
		Transaction transaction = null;
		
		Session session = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		try {
				session.persist(c);	
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
		}
		session.close();
	}
}
