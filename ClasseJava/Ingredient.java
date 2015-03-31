package projetBidon;

public class Ingredient {

	private int id_ingredient;
	private int id_type;
	private String name;
	private String labelQuantity;
	
	public Ingredient(int id_ingredient, int id_type, String name,
			String labelQuantity) {
		super();
		this.id_ingredient = id_ingredient;
		this.id_type = id_type;
		this.name = name;
		this.labelQuantity = labelQuantity;
	}

	public int getId_ingredient() {
		return id_ingredient;
	}

	public void setId_ingredient(int id_ingredient) {
		this.id_ingredient = id_ingredient;
	}

	public int getId_type() {
		return id_type;
	}

	public void setId_type(int id_type) {
		this.id_type = id_type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLabelQuantity() {
		return labelQuantity;
	}

	public void setLabelQuantity(String labelQuantity) {
		this.labelQuantity = labelQuantity;
	}
	
	
	
}
