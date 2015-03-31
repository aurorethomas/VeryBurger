package projetBidon;
import java.util.Date;

public class Order {

	private int id_order;
	private int id_user;
	private Date order_date;
	private Date delivrance_date;
	
	public Order(int id_order, int id_user, Date order_date,
			Date delivrance_date) {
		super();
		this.id_order = id_order;
		this.id_user = id_user;
		this.order_date = order_date;
		this.delivrance_date = delivrance_date;
	}

	public int getId_order() {
		return id_order;
	}

	public void setId_order(int id_order) {
		this.id_order = id_order;
	}

	public int getId_user() {
		return id_user;
	}

	public void setId_user(int id_user) {
		this.id_user = id_user;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public Date getDelivrance_date() {
		return delivrance_date;
	}

	public void setDelivrance_date(Date delivrance_date) {
		this.delivrance_date = delivrance_date;
	}
	
	
}
