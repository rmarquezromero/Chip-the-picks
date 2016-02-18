package net.codejava.springmvc.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.codejava.springmvc.domain.ChipsOutDto;
import net.codejava.springmvc.domain.FormDto;
import net.codejava.springmvc.domain.GamesDto;
import net.codejava.springmvc.domain.SavedGameDto;
import net.codejava.springmvc.service.CasinoService;

@Controller
public class GameController {
	
	private static final Logger logger = LoggerFactory.getLogger(GameController.class);
	
	@Autowired
	CasinoService casinoService;
	
	/**
	 * Load the game home page
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		
		GamesDto games = null;
		
		try {
			// load saved games
			games = (GamesDto) session.getAttribute("games");
			model.addAttribute("games", games);
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			model.addAttribute("serverError", true);
		}
		
		return "home"; 
	}
	
	
	/**
	 * Load the game
	 * @param formDto
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/play", method = RequestMethod.POST)
	public String playGame(@ModelAttribute("formDto") FormDto formDto, Model model, HttpSession session) throws Exception {
		
		ChipsOutDto chipsOutDto = null;
		GamesDto games = null;
		
		try {
			// load game with params
			model.addAttribute("gameForm", formDto);
			chipsOutDto = casinoService.getChipsAndPlayer(formDto.getAmountChips());
			model.addAttribute("result", chipsOutDto);
			
			// load saved games
			games = (GamesDto) session.getAttribute("games");
			model.addAttribute("games", games);
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			model.addAttribute("serverError", true);
		}
		
		return "home"; 
		
	}
	
	/**
	 * Save the game
	 * @param savedGameDto
	 * @param model
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveGame", method = RequestMethod.POST)
	public String saveGame(@ModelAttribute("savedGameDto") SavedGameDto savedGameDto, Model model, HttpSession session) throws Exception {
		
		GamesDto games = null;
		
		try {
			games = casinoService.saveGame(savedGameDto, session);
			model.addAttribute("games", games);
		} catch (Exception e) {
			logger.error(e.getMessage());
			model.addAttribute("serverError", true);
		}
		
		return "home"; 
		
	}
	
	
	/**
	 * Clear all scoress
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/clearScores", method = RequestMethod.GET)
	public String clearScores(Model model, HttpSession session) {
	    session.removeAttribute("games");
	    model.addAttribute("games", null);
	 
	    return "home";
	}
	
	
}
