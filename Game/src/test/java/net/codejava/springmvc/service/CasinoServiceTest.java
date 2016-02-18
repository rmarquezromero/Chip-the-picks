package net.codejava.springmvc.service;

import static org.junit.Assert.assertEquals;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import net.codejava.springmvc.domain.ChipsOutDto;
import net.codejava.springmvc.domain.GamesDto;
import net.codejava.springmvc.domain.SavedGameDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"/spring/appServlet/servlet-context.xml" })

public class CasinoServiceTest {

	private static final Logger logger = LoggerFactory.getLogger(CasinoServiceTest.class);
	
	@Autowired
	private CasinoService casinoService;

	private HttpSession session;
	
	@Test
	public void testGetChipsAndPlayerSuccess() throws Exception {
		
		try {
			ChipsOutDto chipsOutDto = casinoService.getChipsAndPlayer(4);
			HashMap<Integer, Float> chips = chipsOutDto.getChips();
			assertEquals(4, chips.size());
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
	}

	@Test
	public void testSaveGame() throws Exception {
		
		SavedGameDto savedGameDto = null;
		GamesDto gamesDto = null;
		
		try {
			savedGameDto = new SavedGameDto();
			savedGameDto.setNamePlayerGame("pepe");
			savedGameDto.setWinner("computer");
			savedGameDto.setAmountHuman(new Float("1.2"));
			savedGameDto.setAmountComputer(new Float("10"));
			
			gamesDto = casinoService.saveGame(savedGameDto, null);
			
			assertEquals(null, gamesDto);
		} catch (Exception e) {
			logger.error(e.getMessage());
			assertEquals(null, gamesDto);
		}
	}
	
}
