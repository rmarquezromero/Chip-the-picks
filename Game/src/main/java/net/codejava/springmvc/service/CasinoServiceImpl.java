/**
 * 
 */
package net.codejava.springmvc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import net.codejava.springmvc.domain.ChipsOutDto;
import net.codejava.springmvc.domain.GamesDto;
import net.codejava.springmvc.domain.SavedGameDto;

public class CasinoServiceImpl implements CasinoService{

	private static final Logger logger = LoggerFactory.getLogger(CasinoServiceImpl.class);
	
	private Random randomGenerator = new Random();
	
	/**
	 * Get the chips and theirs amount and first player
	 * @return {@link ChipsOutDto}
	 */
	@Override
	public ChipsOutDto getChipsAndPlayer(Integer amountChips) throws Exception {
		
		ChipsOutDto chipsOutDto = null;
		
		try {
			chipsOutDto = new ChipsOutDto();
			chipsOutDto.setChips(getChips(amountChips));
			chipsOutDto.setFirstPlayer(getFirstPlayer());
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return chipsOutDto;
	}
	
	/**
	 * Get the chips and theirs values
	 * @return Map of chips
	 */
	public HashMap<Integer, Float> getChips(Integer amountChips) throws Exception {
		
		HashMap<Integer, Float> map = null;
		
		try {
			map = new HashMap<Integer, Float>();
			
			for (int i = 0; i < amountChips; i++) {
				map.put(new Integer(i), getRandomValue());
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return map;
	}


	/**
	 * Get random player to begin the game
	 */
	public String getFirstPlayer() throws Exception {
		String[] players = {"human", "computer"};
		String player = "computer";
		
		try {
			randomGenerator = new Random();
			int rdm = randomGenerator.nextInt(players.length);
			player = players[rdm];
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return player;
		
	}
	
	/**
	 * Get one random value for chip
	 * @return value for chip
	 */
	public Float getRandomValue() {
		Float value = null;
		String[] values = {"0.1", "0.2", "0.5", "1", "2", "5", "10"};
		
		try {
			randomGenerator = new Random();
			int rdm = randomGenerator.nextInt(values.length);
			value = Float.parseFloat(values[rdm]);
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return value;
	}

	/**
	 * Save the game
	 */
	@Override
	public GamesDto saveGame(SavedGameDto savedGameDto, HttpSession session) throws Exception {
		
		GamesDto games = (GamesDto) session.getAttribute("games");
		List<SavedGameDto> savedGames = null;
		
		try {
			
			if (games == null) {
				games = new GamesDto();
			}
			
			savedGames = games.getSavedGames();
			
			if (savedGames == null) {
				savedGames = new ArrayList<SavedGameDto>();
			}
			savedGames.add(savedGameDto);
			games.setSavedGames(savedGames);
			
			session.setAttribute("games", games);
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	
		return games;
	}


	
}
