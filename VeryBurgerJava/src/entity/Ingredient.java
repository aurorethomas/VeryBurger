package entity;

public class Ingredient {
	private int id_ingredient;
	private String name;
	private String labelquantity;
	
	public Ingredient(int id_ingredient, String name, String labelquantity) {
		this.id_ingredient = id_ingredient;
		this.name = name;
		this.labelquantity = labelquantity;
	}
	
	public int getId_ingredient() {
		return id_ingredient;
	}
	public void setId_ingredient(int id_ingredient) {
		this.id_ingredient = id_ingredient;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLabelquantity() {
		return labelquantity;
	}
	public void setLabelquantity(String labelquantity) {
		this.labelquantity = labelquantity;
	}
	
	
}
