package cartitem;

public class Cartitem {
	private int no;
    private String itemname;
    private double price;
    private int amount;
    
    /*
     * default Student constructor
     */
    public Cartitem(){
    	no = 0;
        itemname = "";
        price = 0;
        amount = 0;
    }

    /*
     * Student constructor with parameters
     */
    public Cartitem(int nno, String nitemname, double nprice, int namount) {
        super();
        this.no = nno;
        this.itemname = nitemname;
        this.price = nprice;
        this.amount = namount;
    }

    public int getNo() {
        return this.no;
    }

    public void setNo(int nno) {
        this.no = nno;
    }
    
    public String getItemname() {
        return this.itemname;
    }

    public void setItemname(String nitemname) {
        this.itemname = nitemname;
    }

    public double getPrice() {
        return this.price;
    }

    public void setPrice(double nprice) {
        this.price = nprice;
    }

    public int getAmount() {
        return this.amount;
    }

    public void setAmount(int namount) {
        this.amount = namount;
    }
}
