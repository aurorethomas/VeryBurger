package projetBidon;

public class Position {

	private int id_menu_order;
	private String label_position;
	
	public Position(int id_menu_order, String label_position) {
		super();
		this.id_menu_order = id_menu_order;
		this.label_position = label_position;
	}

	public int getId_menu_order() {
		return id_menu_order;
	}

	public void setId_menu_order(int id_menu_order) {
		this.id_menu_order = id_menu_order;
	}

	public String getLabel_position() {
		return label_position;
	}

	public void setLabel_position(String label_position) {
		this.label_position = label_position;
	}
	
	
	
}
