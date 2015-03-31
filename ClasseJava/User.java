package projetBidon;

public class User {

	private int id_user;
	private String firstName_user;
	private String surName_user;
	private int position;
	
	
	public User(int id_user, String firstName_user, String surName_user,
			int position) {
		super();
		this.id_user = id_user;
		this.firstName_user = firstName_user;
		this.surName_user = surName_user;
		this.position = position;
	}


	public int getId_user() {
		return id_user;
	}


	public void setId_user(int id_user) {
		this.id_user = id_user;
	}


	public String getFirstName_user() {
		return firstName_user;
	}


	public void setFirstName_user(String firstName_user) {
		this.firstName_user = firstName_user;
	}


	public String getSurName_user() {
		return surName_user;
	}


	public void setSurName_user(String surName_user) {
		this.surName_user = surName_user;
	}


	public int getPosition() {
		return position;
	}


	public void setPosition(int position) {
		this.position = position;
	}
	
	
	
}
