package vo;

public class Cash {
	private int cashNo; //INNER JOIN -> Cash 타입
	private String categoryNo;//FK INNER JOIN -> Map 타입
	private String memberId;
	private String cashDate;//FK INNER JOIN -> Map 타입
	private long cashPrice;
	private String cashMemo;
	private String updatedate;
	private String createdate;
	
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public String getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getCashDate() {
		return cashDate;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	public long getCashPrice() {
		return cashPrice;
	}
	public void setCashPrice(long cashPrice) {
		this.cashPrice = cashPrice;
	}
	public String getCashMemo() {
		return cashMemo;
	}
	public void setCashMemo(String cashMemo) {
		this.cashMemo = cashMemo;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	

	
}
