package projetBidon;
import java.util.Date;

public class Purchase {

	private int id_purchase;
	private Date purchaseDate;
	private Date throwDate;
	private int throw_user_id;
	private int purchasePrice;
	private char availabe;
	private int id_ingredient;
	private int quantite_ingredient;
	private Date expireDate;
	
	public Purchase(int id_purchase, Date purchaseDate, Date throwDate,
			int throw_user_id, int purchasePrice, char availabe,
			int id_ingredient, int quantite_ingredient, Date expireDate) {
		super();
		this.id_purchase = id_purchase;
		this.purchaseDate = purchaseDate;
		this.throwDate = throwDate;
		this.throw_user_id = throw_user_id;
		this.purchasePrice = purchasePrice;
		this.availabe = availabe;
		this.id_ingredient = id_ingredient;
		this.quantite_ingredient = quantite_ingredient;
		this.expireDate = expireDate;
	}

	public int getId_purchase() {
		return id_purchase;
	}

	public void setId_purchase(int id_purchase) {
		this.id_purchase = id_purchase;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public Date getThrowDate() {
		return throwDate;
	}

	public void setThrowDate(Date throwDate) {
		this.throwDate = throwDate;
	}

	public int getThrow_user_id() {
		return throw_user_id;
	}

	public void setThrow_user_id(int throw_user_id) {
		this.throw_user_id = throw_user_id;
	}

	public int getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(int purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public char getAvailabe() {
		return availabe;
	}

	public void setAvailabe(char availabe) {
		this.availabe = availabe;
	}

	public int getId_ingredient() {
		return id_ingredient;
	}

	public void setId_ingredient(int id_ingredient) {
		this.id_ingredient = id_ingredient;
	}

	public int getQuantite_ingredient() {
		return quantite_ingredient;
	}

	public void setQuantite_ingredient(int quantite_ingredient) {
		this.quantite_ingredient = quantite_ingredient;
	}

	public Date getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}
	
	
	
}
