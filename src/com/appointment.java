package com;

import java.util.ArrayList;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import com.google.gson.*;
import org.json.simple.*;

import model.*;

import org.apache.tomcat.util.json.JSONParser;
import org.jsoup.*;
import org.jsoup.parser.*;
import org.jsoup.nodes.Document;

@Path("/appointment")
public class appointment {

	appointmentModel m_app =new appointmentModel();
	
	@GET
	@Path("/")
	@Produces(MediaType.TEXT_HTML)
	public String view(String app_text)
	{
		return m_app.getAppointment();
	}
	
	@POST
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.TEXT_PLAIN)
	public String add(String app_text)
	{
		
		//Convert the input string to a JSON object
		JsonObject app = new JsonParser().parse(app_text).getAsJsonObject();
		
		m_app.addAppointment(app.get("name").getAsString(),Integer.parseInt(app.get("age").getAsString()),app.get("gender").getAsString(),app.get("dname").getAsString(),app.get("date").getAsString(),app.get("time").getAsString(),app.get("hname").getAsString());
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(m_app.getSuccess()));
		
		return json.toString();
			
		
	}
	
	@PUT
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.TEXT_PLAIN)
	public String edit(String app_text)
	{
		
		//Convert the input string to a JSON object
		JsonObject app = new JsonParser().parse(app_text).getAsJsonObject();
		
		m_app.editAppointment(app.get("name").getAsString(),Integer.parseInt(app.get("age").getAsString()),app.get("gender").getAsString(),app.get("dname").getAsString(),app.get("date").getAsString(),app.get("time").getAsString(),app.get("hname").getAsString(),Integer.parseInt(app.get("id").getAsString()));
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(m_app.getSuccess()));
		
		return json.toString();
			
	}
	
	@DELETE
	@Path("/")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.TEXT_PLAIN)
	public String delete(String app_text)
	{
		
		//Convert the input string to a JSON object
		JsonObject app = new JsonParser().parse(app_text).getAsJsonObject();
		
		m_app.deleteAppointment(Integer.parseInt(app.get("id").getAsString()));
		
		JSONObject json = new JSONObject();
		json.put("success", Integer.toString(m_app.getSuccess()));
		
		return json.toString();
			
		
	}
	
	@POST
	@Path("/get")
	@Produces(MediaType.TEXT_HTML)
	public String viewOne(String app_text)
	{
		JsonObject app = new JsonParser().parse(app_text).getAsJsonObject();
		
		return m_app.getAppointment(Integer.parseInt(app.get("id").getAsString())).toString();
	}
	
}
