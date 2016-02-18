package net.codejava.springmvc.domain;

import java.io.Serializable;
import java.util.HashMap;

public class ChipsOutDto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7132127043297900228L;
	
	private HashMap<Integer, Float> chips;
	private String firstPlayer;

	public HashMap<Integer, Float> getChips() {
		return chips;
	}

	public void setChips(HashMap<Integer, Float> chips) {
		this.chips = chips;
	}

	public String getFirstPlayer() {
		return firstPlayer;
	}

	public void setFirstPlayer(String firstPlayer) {
		this.firstPlayer = firstPlayer;
	}
	
	
	
}
