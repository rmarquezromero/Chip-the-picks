package net.codejava.springmvc.domain;

import java.io.Serializable;

public class FormDto implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 543055037881852554L;
	
	
	private String namePlayer;
	private Integer amountChips;
	
	public String getNamePlayer() {
		return namePlayer;
	}
	public void setNamePlayer(String namePlayer) {
		this.namePlayer = namePlayer;
	}
	public Integer getAmountChips() {
		return amountChips;
	}
	public void setAmountChips(Integer amountChips) {
		this.amountChips = amountChips;
	}
	
	
	
}
