package projetBidon;

public class Recipe {

	private int id_recipe;
	private String name_recipe;
	private double price;
	
	public Recipe(int id_recipe, String name_recipe, double price) {
		super();
		this.id_recipe = id_recipe;
		this.name_recipe = name_recipe;
		this.price = price;
	}

	public int getId_recipe() {
		return id_recipe;
	}

	public void setId_recipe(int id_recipe) {
		this.id_recipe = id_recipe;
	}

	public String getName_recipe() {
		return name_recipe;
	}

	public void setName_recipe(String name_recipe) {
		this.name_recipe = name_recipe;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
	
}
