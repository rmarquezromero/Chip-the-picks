<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	
	<title>Home</title>
	
	<style type="text/css">
	
		body {
			margin: 30px;
		}
	
		h1 {
			font-family:  arial;
			font-weight: normal;
	        font-size: 1.75em;
			letter-spacing: .2em;
			line-height: 3.1em;
			margin:0px;
			text-transform: uppercase;
		}
	
		.circle-base {
		    border-radius: 50%;
		    behavior: url(PIE.htc); 
		}
		
		.type1 {
		    width: 100px;
		    height: 100px;
		    background: yellow;
		    border: 3px solid red;
		    display: table-cell;
		    margin-left: 10px;
		}
		
		.chip-number {
			text-align: center;
			vertical-align: middle;
			line-height: 90px;
			font-size: 25px;
			/*margin-left: 45px;*/
		}
		
		.type1:hover {
	    	background: red;
	    	color: white;
	    	transform: scale(1.2);
	    }
		
		.no-selectable {
			opacity: 0.2;
		}
		
		.selectable {
			opacity: 1;
		}
		
		.chips-container {
			display: table;
		}
		
		.div-cheating {
		    margin-top: 20px;
		    margin-bottom: 20px;
		    color: red;
		    font-family: fantasy;
		    font-size: 31px;
		}
		
		/*table a:link {
			color: #666;
			font-weight: bold;
			text-decoration:none;
		}
		table a:visited {
			color: #999999;
			font-weight:bold;
			text-decoration:none;
		}
		table a:active,
		table a:hover {
			color: #bd5a35;
			text-decoration:underline;
		}*/
		table {
			font-family:Arial, Helvetica, sans-serif;
			color:#666;
			font-size:12px;
			text-shadow: 1px 1px 0px #fff;
			background:#eaebec;
			margin:20px;
			border:#ccc 1px solid;
		
			-moz-border-radius:3px;
			-webkit-border-radius:3px;
			border-radius:3px;
		
			-moz-box-shadow: 0 1px 2px #d1d1d1;
			-webkit-box-shadow: 0 1px 2px #d1d1d1;
			box-shadow: 0 1px 2px #d1d1d1;
		}
		table th {
			padding:21px 25px 22px 25px;
			border-top:1px solid #fafafa;
			border-bottom:1px solid #e0e0e0;
		
			background: #ededed;
			background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
			background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
		}
		table th:first-child {
			text-align: left;
			padding-left:20px;
		}
		table tr:first-child th:first-child {
			-moz-border-radius-topleft:3px;
			-webkit-border-top-left-radius:3px;
			border-top-left-radius:3px;
		}
		table tr:first-child th:last-child {
			-moz-border-radius-topright:3px;
			-webkit-border-top-right-radius:3px;
			border-top-right-radius:3px;
		}
		table tr {
			text-align: center;
			padding-left:20px;
		}
		table td:first-child {
			text-align: left;
			padding-left:20px;
			border-left: 0;
		}
		table td {
			padding:2px;
			border-top: 1px solid #ffffff;
			border-bottom:1px solid #e0e0e0;
			border-left: 1px solid #e0e0e0;
		
			background: #fafafa;
			background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
			background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
		}
		table tr.even td {
			background: #f6f6f6;
			background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
			background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
		}
		table tr:last-child td {
			border-bottom:0;
		}
		table tr:last-child td:first-child {
			-moz-border-radius-bottomleft:3px;
			-webkit-border-bottom-left-radius:3px;
			border-bottom-left-radius:3px;
		}
		table tr:last-child td:last-child {
			-moz-border-radius-bottomright:3px;
			-webkit-border-bottom-right-radius:3px;
			border-bottom-right-radius:3px;
		}
		table tr:hover td {
			background: #f2f2f2;
			background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
			background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);	
		}	
		
		
	</style>
	
	<script type="text/javascript">
	
		$(document).ready(function(){
			console.log("Game loaded");
			var currentUser = undefined;
			
			//disabled F5
			$(document).on("keydown", disableF5);
			
			
			var name = $('#idName'),
				amountChips = $('#idAmount'),
				firstPlayer = $('#firstPlayer'),
				btnPlay = $('#btnPlay');
			
			if (name.val() != '' && amountChips.val() != '') {
				name.prop('disabled', true);
				amountChips.prop('disabled', true);
				btnPlay.prop('disabled', true);
			}
			
			if (firstPlayer.val() == 'computer') {
				playComputer();
			}
			
			$('#btnClearScores').on('click', function() {
				if (confirm("Scores will be removed, are you sure?")) {
					clearScores();
				} 
			});
			
			$('#btnPlay').on('click', onClickBtnPlay);
			
			$('#chkCheatMode').on('change', enableCheatMode);
			
		});
		function selectChip(chipMap) {
			
			if ((typeof(currentUser) != "undefined") && currentUser == "computer") {
				$('#idCheating').show();
				return;
			}
			
			var amountChips = parseInt($('#idAmount').val()),
				length = $('#divChips').children().length,
				chip = chipMap.split('='),
				idx = parseInt(chip[0]),
				value = parseFloat(chip[1]),
				chipEl = $('#idChip' + idx),
				firstDiv = $('#divChips').find('div').first(),
				lastDiv = $('#divChips').find('div').last();
			
			if (lastDiv[0] == chipEl[0] || firstDiv[0] == chipEl[0]) {
				var inputChip = chipEl.find('input'),
					numberChip = inputChip[0].id;
					spanHumanGains = $('#gainsHuman');
				
				$('#labelInfo').text('You have chosen the chip number ' + numberChip + ' with a value of ' + value + '$');
				$('#labelInfo').append('<br>Please, wait until computer take a chip. This will take 3 seconds!');
				
				spanHumanGains.text((spanHumanGains.text() != '') 
						? parseFloat(spanHumanGains.text()) + parseFloat(value)
						: parseFloat(value));
				
				if ($('#divChips').find('div').last()[0] != chipEl[0]) {
					$('#divChips').find('div').first().remove();
					$('#divChips').find('div').first().removeClass('no-selectable');
				} else {
					$('#divChips').find('div').last().remove();
					$('#divChips').find('div').last().removeClass('no-selectable');
				}
				if (length != 1) {
					playComputer();	
				} else if (length == 1) {
					checkWinner();
				}
				
			} else {
				alert('Please, take a chip from one of the ends of the line');
			}
		}
		
		function playComputer() {
			
			currentUser = "computer";
			
			var chips = $('#divChips').children();
			
			setTimeout(function(){
				
				if (chips.length == 1) {
					var chipEl = $('#divChips').find('div').first(),
						inputChip = chipEl.find('input'),
						numberChip = inputChip[0].id,
						value = inputChip.val(),
						spanComputerGains = $('#gainsComputer');
					
					$('#labelInfo').text('Computer has chosen the last chip number ' + numberChip + ' with a value of ' + value + '$');
					
					spanComputerGains.text((spanComputerGains.text() != '') 
							? parseFloat(spanComputerGains.text()) + parseFloat(value)
							: parseFloat(value));
					
					$('#divChips').find('div').first().remove();
					
					checkWinner();
					
				} else {
					// take random chip
					var rdm = Math.floor(Math.random() * 2),
						chosenChip = chips[(rdm == 0) ? 0 : (chips.length-1)],
						chipEl = $('#' + chosenChip.id),
						inputChip = chipEl.find('input'),
						numberChip = inputChip[0].id,
						value = inputChip.val(),
						spanComputerGains = $('#gainsComputer');
					
					$('#labelInfo').text('Computer has chosen the chip number ' + numberChip + ' with a value of ' + value + '$');
					
					spanComputerGains.text((spanComputerGains.text() != '') 
							? parseFloat(spanComputerGains.text()) + parseFloat(value)
							: parseFloat(value));
					
					if (rdm == 0) {
						$('#divChips').find('div').first().remove();
						$('#divChips').find('div').first().removeClass('no-selectable');
					} else {
						$('#divChips').find('div').last().remove();
						$('#divChips').find('div').last().removeClass('no-selectable');
					}
					
					playHuman();
				} 
				
			}, 3000);
			
			//setTimeout(function(){ alert("Hello"); }, 3000);
		}
		
		function playHuman() {
			currentUser = "human";
			$('#idCheating').hide();
			//setTimeout(function(){ alert("Hello"); }, 3000);
			$('#labelInfo').append('<br>Now, its your turn human. Take a chip from one of the ends of the line.');
		}
		
		function checkWinner() {
			var gainsComputer = $('#gainsComputer'),
				gainsHuman = $('#gainsHuman'),
				gainsComputerVal = parseFloat(gainsComputer.text()),
				gainsHumanVal = parseFloat(gainsHuman.text());
			
			if (gainsHumanVal > gainsComputerVal) {
				alert('WIN HUMAN!! NOW GAME WILL BE SAVED');
				$('#idWinner').val('human');
			} else if (gainsHumanVal < gainsComputerVal) {
				alert('win computer!! NOW GAME WILL BE SAVED')
				$('#idWinner').val('computer');
			} else {
				alert('Computer and human have tied!! NOW GAME WILL BE SAVED');
				$('#idWinner').val('tie');
			}

			$('#idNamePlayerGame').val($('#idName').val());
			$('#idAmountHuman').val(gainsHumanVal);
			$('#idAmountComputer').val(gainsComputerVal);
			$('#formSaveGame').submit();
			
		}
		
		function clearScores() {
			$.ajax({
	            url : "http://localhost:8080/springmvc/clearScores",
	            success : function(data) {
	                //$('#result').html(data);
	                $('#idScores').remove();
	            }
	        });
		}
		
		function disableF5(e) { 
			if ((e.which || e.keyCode) == 116) {
				e.preventDefault();
				alert('F5 is disabled my friend :)');
			}
		};
		
		function onClickBtnPlay(e) {
			e.preventDefault();
			var form = $('#formPlay'),
				nameFld = $('#idName'),
				amountChipsFld = $('#idAmount'),
				amount = parseInt(amountChipsFld.val()),
				regOnlyNumbers = /^\d+$/;
			
			if (!isValidValue(nameFld.val()) || !isValidValue(amountChipsFld.val())) {
				alert('Name and amount of chips are required.');
			} else if (!regOnlyNumbers.test(amount)
					|| (amount % 2 != 0)
					|| amount < 4
					|| amount > 20
				) {
				alert('Amount of chips must be even and greater than 4 and less than 20');
				amountChipsFld.val('');
				amountChipsFld.focus();
			} else {
				form.submit();
			}
			
		}
		
		function isValidValue(val) {
			val = val.trim();
			if (val == "" || val == null || val == undefined) {
				return false;
			}
			return true;
		}
		
		function enableCheatMode() {
			var length = $('#divChips').children().length;
			
			if (length == 0) {
				alert('Please, start the game!');
				return;
			}
			
			if($('#chkCheatMode').is(':checked')) {
				$('p[id^="chipNumber"]').hide();
				$('p[id^="chipAmount"]').show();
			} else {
				$('p[id^="chipNumber"]').show();
				$('p[id^="chipAmount"]').hide();
			}
		}
		
	</script>
	
</head>
<body>
<h1>
	PICK THE CHIP
</h1>



<form id="formPlay" action="http://localhost:8080/springmvc/play" method="POST">
	<input id="idName" name="namePlayer" placeholder="Your name here..." maxlength="30" value="${gameForm.namePlayer}" required style="text-transform: uppercase;"/>
	<input id="idAmount" name="amountChips" placeholder="Amount of chips..." maxlength="2" value="${gameForm.amountChips}" required/>
	<input id="btnPlay" type="button" value="Play">
	<input id="chkCheatMode" type="checkbox"/><label>Enable cheat mode</label>
</form>

<div style="margin-bottom:20px">
	<input id="firstPlayer" type="hidden" value="${result.firstPlayer}">
	<c:if test="${result.firstPlayer ne null }">
		<label id="labelInfo">Start to play... <c:out value="the ${result.firstPlayer}."></c:out>
	</c:if>
		<c:choose>
			<c:when test="${result.firstPlayer == 'human'}">
				Now, it's your turn human. Take a chip from one of the ends of the line.
			</c:when>
			<c:when test="${result.firstPlayer == 'computer'}">
				Please, wait until computer take a chip. This will take 3 seconds!
			</c:when>
			<c:otherwise>
				Fill name and amount chips and click play button!!
			</c:otherwise>
		</c:choose>
	</label>
</div>

<div id="divChips" class="chips-container">
	<c:forEach items="${result.chips}" var="chip" varStatus="status">
		
		<div id="idChip${chip.key}" class="circle-base type1 ${(status.index == 0 or status.index == fn:length(result.chips)-1) ? 'selectable' : 'no-selectable' }" 
				onclick="javascript:selectChip('${chip}')">
			<input id="${status.index + 1}" type="hidden" value="${chip.value}" />
			<p id="chipNumber${status.index}" class="chip-number"><c:out value="${status.index + 1}"></c:out></p>
			<p id="chipAmount${status.index}" class="chip-number" style="display:none"><c:out value="${chip.value}"></c:out></p>
			<!-- <div><c:out value="${chip.key}"></c:out> - <c:out value="${chip.value}"></c:out></div> -->
		</div>
		
	</c:forEach>
</div>

<div id="idCheating" style="display:none" class="div-cheating"><span>STOP CHEATING!!!</span></div>
<table cellspacing="0">
    <tr class="even">
        <th>Computer gains</th>
        <th>Human gains</th>
    </tr>
    <tr>
    	<td><span id="gainsComputer"></span></td>
    	<td><span id="gainsHuman"></span></td>
    </tr>
</table>

<form id="formSaveGame" action="http://localhost:8080/springmvc/saveGame" method="POST">
	<input id="idNamePlayerGame" name="namePlayerGame" type="hidden"/>
	<input id="idWinner" name="winner" type="hidden"/>
	<input id="idAmountHuman" name="amountHuman" type="hidden"/>
	<input id="idAmountComputer" name="amountComputer" type="hidden"/>
</form>


<!-- TABLE SCORES -->
<c:if test="${games ne null}">
	<div id="idScores">
		<div style="margin:20px; width: 27%;">
			<label>SCORES</label>
			<input id="btnClearScores" type="button" value="Clear scores and hide table" style="float:right"/>
		</div>
		<div>
			<table cellspacing="0">
			    <tr>
			        <th>Player</th>
			        <th>Winner</th>
			        <th>Amount Human</th>
			        <th>Amount Player</th>
			    </tr>
			    <c:forEach items="${games.savedGames}" var="savedGame" varStatus="status">
			    <tr class="${(status.index % 2 == 0) ? 'even' : '' }">
			        <td>
			            <c:out value="${savedGame.namePlayerGame}" />
			        </td>
			        <td>
			            <c:out value="${savedGame.winner}" />
			        </td>
			        <td>
			            <c:out value="${savedGame.amountHuman}" />
			        </td>
			        <td>
			            <c:out value="${savedGame.amountComputer}" />
			        </td>
			    </tr>
			    </c:forEach>
			</table>
		</div>
	</div>
</c:if>


</body>
</html>

