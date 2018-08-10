package com.shopkart;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.sun.javafx.geom.CubicApproximator;

import oracle.net.aso.p;
import oracle.net.aso.q;

public class BusinessObject {
	public static boolean isAdmin(String userName, String password) {
		if (userName.equalsIgnoreCase("admin") && password.equalsIgnoreCase("admin"))
			return true;
		else
			return false;
	}

	public static ArrayList<Users> getUsers(String userName, String password) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO uDao = (ShopKartDAO) context.getBean("eDao");
		return uDao.getUsers("select * from Users where userName='" + userName + "' and password='" + password + "'");
	}

	public static String getTransQuery(String productId, int quantity, String qType, String userName) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO pDao = (ShopKartDAO) context.getBean("eDao");
		ArrayList<Product> lst = pDao.getProducts("select * from Product where productId='" + productId + "'");
		int price = lst.get(0).getPrice() * quantity;
		int taxRate = lst.get(0).getTaxRate();
		int discountPerc = lst.get(0).getDiscountPerc();
		int discountAmt = price * discountPerc / 100;
		int taxAmt = price * taxRate / 100;
		int netAmt = price + taxAmt - discountAmt;
		String sql = null;
		if (qType.equalsIgnoreCase("insert"))
			sql = "insert into transaction values('" + productId + "'," + quantity + "," + discountAmt + "," + netAmt
					+ ",'"+userName+"')";
		else
			sql = "update transaction set Quantity=" + quantity + ", DiscountAmt=" + discountAmt + ", NetAmt=" + netAmt
					+ " where ProductId='" + productId + "'";
		return sql;
	}

	public static String getProductName(String productId) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO pDao = (ShopKartDAO) context.getBean("eDao");
		ArrayList<Product> lst = pDao.getProducts("select * from Product where productId='" + productId + "'");
		return lst.get(0).getProductName();
	}
	public static int getProductPrice(String productId) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO pDao = (ShopKartDAO) context.getBean("eDao");
		ArrayList<Product> lst = pDao.getProducts("select * from Product where productId='" + productId + "'");
		return lst.get(0).getPrice();
	}

	public static int getProductTax(String productId) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO pDao = (ShopKartDAO) context.getBean("eDao");
		ArrayList<Product> lst = pDao.getProducts("select * from Product where productId='" + productId + "'");
		return lst.get(0).getTaxRate();
	}

	public static void insertOrder(String payMethod, String userName) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO pDao = (ShopKartDAO) context.getBean("eDao");
		ArrayList<Transaction> transactionList = pDao.getTrans("select * from Transaction");
		String orderId = Integer.toString(pDao.getOrderId());
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
		int gross=0,tax=0,discount=0,net=0;
		String orderdate = formatter.format(date);
		for (Transaction trans : transactionList) {
			gross+=trans.getQuantity()*getProductPrice(trans.getProductId());
			tax+=gross*getProductTax(trans.getProductId())/100;
			discount+=trans.getDistcountAmt();
			net+=trans.getNetAmt();
		}
		String sql = "insert into orderdetails values('"+orderId+"','"+orderdate+"','"+userName+"','"+payMethod+"',"+gross+","+tax+","+discount+","+net+")";
		pDao.updateTable(sql);		
	}
	public static void deleteTrans(String userName) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO pDao = (ShopKartDAO) context.getBean("eDao");
		pDao.updateTable("delete from Transaction where userName='"+userName+"'");
	}
	
	public static void revertTrans(String userName) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO pDao = (ShopKartDAO) context.getBean("eDao");
		ArrayList<Transaction> transactionList = pDao.getTrans("select * from Transaction where userName='"+userName+"'");
		for (Transaction trans : transactionList) {
			int quantity = trans.getQuantity();
			String productId = trans.getProductId();			
			ArrayList<Product> prArrayList = pDao.getProducts("select * from Product where Productid='"+productId+"'");
			quantity+=prArrayList.get(0).getQuantity();
			String sql = "update Product set Quantity="+quantity+" where productId='"+productId+"'";
			pDao.updateTable(sql);
		}
		deleteTrans(userName);
	}
	public static String getAddress(String userName) {
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO pDao = (ShopKartDAO) context.getBean("eDao");
		ArrayList<Users> tList = pDao.getUsers("select * from Users where userName='"+userName+"'");
		return tList.get(0).getAddress();
	}

	public static String addIntoKart(String productId, int quantity, String userName) {
		String sql = "select * from Product where productId='"+productId+"'";
		ApplicationContext context = new ClassPathXmlApplicationContext("Beans.xml");
		ShopKartDAO sp = (ShopKartDAO) context.getBean("eDao");
		ArrayList<Product> productList = sp.getProducts(sql);
		int currentProductQuantity=productList.get(0).getQuantity();
		if(quantity>currentProductQuantity) {
			return"We Only have "+currentProductQuantity+" Available!!!";
		}	
		sql = "update product set quantity="+(currentProductQuantity-quantity)+" where productId='"+productId+"'";
		sp.updateTable(sql);
		
		sql="select * from Transaction where ProductId='"+productId+"' and userName='"+userName+"'";
		ArrayList<Transaction> transList = sp.getTrans(sql);
		if(transList.size()>0) {
			//update
			int currentTransQuantity = transList.get(0).getQuantity()+quantity;
			sql = BusinessObject.getTransQuery(productId, currentTransQuantity, "update","");
		}
		else
		{
			//insert				
			sql =BusinessObject.getTransQuery(productId, quantity, "insert",userName);
		}
		sp.updateTable(sql);
		return "Item Added to Cart";
	}
}
