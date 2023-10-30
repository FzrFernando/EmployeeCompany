package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

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
	
	public static <E> E addCharacter(Class<E> c, Object o) throws Exception{
		Transaction transaction = null;
		Session session = null;
		E result = null;
		try {
			session = DbUtility.getSessionFactory().openSession();
			transaction = session.beginTransaction();
		} catch (Exception e) {
			throw new Exception("Error en la base de datos");
		} try {
			result = (E) session.merge(o);
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
		}
		session.close();
		return (E) result;
	}
}
