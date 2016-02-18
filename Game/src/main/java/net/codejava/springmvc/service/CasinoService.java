/**
 * 
 */
package net.codejava.springmvc.service;

import javax.servlet.http.HttpSession;

import net.codejava.springmvc.domain.ChipsOutDto;
import net.codejava.springmvc.domain.GamesDto;
import net.codejava.springmvc.domain.SavedGameDto;

public interface CasinoService {

	public ChipsOutDto getChipsAndPlayer(Integer amountChips) throws Exception;
	
	public GamesDto saveGame(SavedGameDto savedGameDto, HttpSession session) throws Exception;
}
