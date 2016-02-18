package net.codejava.springmvc.domain;

import java.io.Serializable;

public class SavedGameDto implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1065245948076277198L;
	
	private String namePlayerGame;
	private String winner;
	private Float amountHuman;
	private Float amountComputer;
	
	
	
	public String getNamePlayerGame() {
		return namePlayerGame;
	}
	public void setNamePlayerGame(String namePlayerGame) {
		this.namePlayerGame = namePlayerGame;
	}
	public String getWinner() {
		return winner;
	}
	public void setWinner(String winner) {
		this.winner = winner;
	}
	public Float getAmountHuman() {
		return amountHuman;
	}
	public void setAmountHuman(Float amountHuman) {
		this.amountHuman = amountHuman;
	}
	public Float getAmountComputer() {
		return amountComputer;
	}
	public void setAmountComputer(Float amountComputer) {
		this.amountComputer = amountComputer;
	}
	
	
	
}
