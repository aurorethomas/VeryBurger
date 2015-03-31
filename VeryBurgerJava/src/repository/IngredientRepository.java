package repository;

import java.sql.*;
//import java.sql.SQLException;
import java.util.ArrayList;

import application.Database;
import entity.Ingredient;


public class IngredientRepository {
	private ArrayList<Ingredient> ingredients;
	private Database database;
	
	public IngredientRepository(Database database){
		ingredients = new ArrayList<Ingredient>();
		this.database = database;
	}
	
	public ArrayList<Ingredient> getAllIngredients(){
		Connection conn = this.database.getConn();
		try{
			Statement stm = conn.createStatement();
			String req = "SELECT * FROM INGREDIENT";
			ResultSet res = stm.executeQuery(req);
			// clearing ingredients list before inserting new list
			ingredients.clear();
			while(res.next()){
				int id = res.getInt("id_ingredient");
				String name = res.getString("name");
				String labelquantity = res.getString("labelquantity");
				// creating and inserting new Ingredient in arraylist
				this.ingredients.add(new Ingredient(id, name, labelquantity));
			}
			res.close();
		}catch(SQLException e){
			// erreur
		}
		
		// returning arraylist of ingredients
		return ingredients;
	}
}
