package projetBidon;

public class Menu {

	private int id_menu;
	private String name_menu;
	private double price_menu;
	
	
	public int getId_menu() {
		return id_menu;
	}


	public void setId_menu(int id_menu) {
		this.id_menu = id_menu;
	}


	public String getName_menu() {
		return name_menu;
	}


	public void setName_menu(String name_menu) {
		this.name_menu = name_menu;
	}


	public double getPrice_menu() {
		return price_menu;
	}


	public void setPrice_menu(double price_menu) {
		this.price_menu = price_menu;
	}


	public Menu(int id_menu, String name_menu, double price_menu) {
		super();
		this.id_menu = id_menu;
		this.name_menu = name_menu;
		this.price_menu = price_menu;
	}
		
}
