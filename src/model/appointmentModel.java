package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.JSONObject;

import connection.DBConnect;


public class appointmentModel {

private int success;
	
	public void addAppointment(String name,int age,String gender,String dname,String date,String time,String hname) {
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			connection = DBConnect.getDBConnection();
			
			//insert value
			preparedStatement = connection.prepareStatement("insert into appointment (name,age,gender,dname,date,time,hname) values (?,?,?,?,?,?,?)");
			preparedStatement.setString(1, name);
			preparedStatement.setInt(2, age);
			preparedStatement.setString(3,gender);
			preparedStatement.setString(4,dname);
			preparedStatement.setString(5, date);
			preparedStatement.setString(6,time);
			preparedStatement.setString(7,hname);
			preparedStatement.execute();
			preparedStatement.close();
			connection.close();
			setSuccess(1);
		
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess(0);
			System.out.println(e.getMessage());
		}
	}

	public int getSuccess() {
		return success;
	}

	public void setSuccess(int success) {
		this.success = success;
	}
	
	public String getAppointment() {
		
		Connection connection;
		PreparedStatement preparedStatement;
		String table="";
		
		try {
			
			connection = DBConnect.getDBConnection();
			preparedStatement = connection.prepareStatement("SELECT * FROM appointment");
			
			ResultSet resultSet = preparedStatement.executeQuery();
			
			table = "<table class='table'><thead>"
		            +"<tr>"
		            +"<th class='tableTh'>ID</th>"
		                +"<th class='tableTh'>Name</th>"
		                +"<th class='tableTh'>Age</th>"
		                +"<th class='tableTh'>Gender</th>"
		                +"<th class='tableTh'>Doctor Name</th>"
		                +"<th class='tableTh'>Date</th>"
		                +"<th class='tableTh'>Time</th>"
		                +"<th class='tableTh'>Hospital</th>"
		                +"<th class='tableTh'>Action</th>"
		                +"</tr>"
		            +"</thead><tbody>";
			
			while (resultSet.next()) {
				
				String button = "<button type='button' onclick='edit("+resultSet.getString(1)+")' class='btn btn-primary'>Edit</button><br><button type='button' onclick='deletes("+resultSet.getString(1)+")' class='btn btn-warning'>Delete</button>";
				
				table = table+"<tr><td class='tableTh'>"+resultSet.getString(1)+"</td>"
						+ "<td class='tableTh'>"+resultSet.getString(2)+"</td>"
						+ "<td class='tableTh'>"+resultSet.getString(3)+"</td>"
						+ "<td class='tableTh'>"+resultSet.getString(4)+"</td>"
						+ "<td class='tableTh'>"+resultSet.getString(5)+"</td>"
						+ "<td class='tableTh'>"+resultSet.getString(6)+"</td>"
						+ "<td class='tableTh'>"+resultSet.getString(7)+"</td>"
						+ "<td class='tableTh'>"+resultSet.getString(8)+"</td>"
						+ "<td class='tableTh'>"+button+"</td>"
					  + "</tr>";
				
			}
			
			preparedStatement.close();
			connection.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return table+"</table>";
	}

	public void editAppointment(String name,int age,String gender,String dname,String date,String time,String hname,int id) {
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			connection = DBConnect.getDBConnection();
			
				//update value
				preparedStatement = connection.prepareStatement("UPDATE appointment SET name=?,age=?,gender=?,dname=?,date=?,time=?,hname=? where id=?");
				preparedStatement.setString(1, name);
				preparedStatement.setInt(2, age);
				preparedStatement.setString(3,gender);
				preparedStatement.setString(4,dname);
				preparedStatement.setString(5, date);
				preparedStatement.setString(6,time);
				preparedStatement.setString(7,hname);
				preparedStatement.setInt(8,id);
				preparedStatement.execute();
				preparedStatement.close();
				connection.close();
				setSuccess(1);
				
		
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess(0);
			System.out.println(e.getMessage());
		}
	}

	public void deleteAppointment(int visit) {
		Connection connection;
		PreparedStatement preparedStatement;
		
		try {
			connection = DBConnect.getDBConnection();
			
			//delete hospital
			preparedStatement = connection.prepareStatement("DELETE FROM appointment WHERE id=?");
			preparedStatement.setInt(1, visit);
			preparedStatement.execute();
			
			setSuccess(1);
		
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess(0);
		}
	}
	
	public JSONObject getAppointment(int id) {
		Connection connection;
		PreparedStatement preparedStatement;
		JSONObject json = new JSONObject();
		
		try {
			connection = DBConnect.getDBConnection();
			
			preparedStatement = connection.prepareStatement("SELECT * FROM appointment where id=?");
			preparedStatement.setInt(1, id);
			ResultSet rs = preparedStatement.executeQuery();

			while(rs.next())
			{
				json.put("id", rs.getInt(1));
				json.put("name", rs.getString(2));
				json.put("age", rs.getInt(3));
				json.put("gender", rs.getString(4));
				json.put("dname", rs.getString(5));
				json.put("date", rs.getString(6));
				json.put("time", rs.getString(7));
				json.put("hname", rs.getString(8));
			}
			
		}catch (ClassNotFoundException | SQLException  e) {
			setSuccess(0);
		}
		return json;
	}
	
}
