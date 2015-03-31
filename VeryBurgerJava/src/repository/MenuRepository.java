package repository;
import java.sql.*;
import java.util.ArrayList;

import application.Database;
import entity.Menu;

public class MenuRepository {
	private ArrayList<Menu> menus;
	private Database database;

	public MenuRepository(Database database){
		menus = new ArrayList<Menu>();
		this.database = database;
	}
	
	/*public boolean createMenu(Menu menu){
		
	}
	
	public boolean deleteMenu(Menu menu){
		
	}
	
	public boolean updateMenu(Menu menu){
		
	}
*/
	
}
