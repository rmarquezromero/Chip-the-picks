package net.codejava.springmvc.domain;

import java.io.Serializable;
import java.util.List;

public class GamesDto implements Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3578293603163299965L;
	
	
	private List<SavedGameDto> savedGames;

	public List<SavedGameDto> getSavedGames() {
		return savedGames;
	}

	public void setSavedGames(List<SavedGameDto> savedGames) {
		this.savedGames = savedGames;
	}
	
	
}
