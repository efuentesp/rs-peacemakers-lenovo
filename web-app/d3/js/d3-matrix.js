var columns,
	rows;

var colorScheme = 'rbow2';

var data;

d3.select("#matrix").classed(colorScheme, true);
//d3.json("/cf-peacemakers/sociometricTestResults/matrix/" + $('#socialGroup').val(), matrix); //Producci—n
//d3.json("/sociometricTestResults/matrix/" + $('#socialGroup').val(), matrix);  //Desarrollo


console.log("Start...");
$("#loading").html('<img width="200" height="200" alt="Wait a second..." src="/rs-peacemakers/static/images/spinner8.gif">');

d3.json($('#restURI').val(), matrix)

// All, PC, Mobile control event listener
$('input[name="type"]').change(function() {					
	
	var type = $(this).val();

	//console.log("Button changed: " + type);

	d3.selectAll('fieldset#type label').classed('sel', false);
	d3.select('label[for="type_' + type + '"]').classed('sel', true);

	//console.log("selected="+type);
	
	reColorTiles(type);

});

//var browser = BrowserDetect;

// Main function
function matrix(json) {
	data = json
	
	console.log("Stop..");
	$("#loading").html('');
	
	//console.log("tests: " + data.tests.length);

	columns = data.headers;
	rows = data.headers;
	
	createTiles();
	reColorTiles(0);
}

function createTiles() {

	//console.log("createTiles")
	var html = '<table id="tiles" class="front">';

	html += '<tr><th><div>&nbsp;</div></th>';

	for (var h = 0; h < columns.length; h++) {
		html += '<th class="h' + h + '">' + columns[h].seq + '</th>';
	}
	
	html += '</tr>';

	for (var d = 0; d < rows.length; d++) {
		html += '<tr class="d' + d + '">';
		html += '<th>' + rows[d].fullname + " [" + rows[d].seq + "] " + '</th>';
		for (var h = 0; h < columns.length; h++) {
			html += '<td id="d' + d + 'h' + h + '" class="d' + d + ' h' + h + '"><div class="tile"><div class="face front"></div><div class="face back"></div></div></td>';
		}
		html += '</tr>';
	}
	
	html += '</table>';

	d3.select('#matrix').html(html);
}

function reColorTiles(test) {
	
	var	side = d3.select('#tiles').attr('class');
	
	if (side === 'front') {
		side = 'back';
	} else {
		side = 'front';
	}

	//console.log("test[" + test + "]: " + data.tests[test].tiles.length);
	
	for (var d = 0; d < data.tests[test].tiles.length; d++) {
		for (var h = 0; h < data.tests[test].tiles[d].length; h++) {

			var sel = '#d' + d + 'h' + h + ' .tile .' + side;
			
			// erase all previous bucket designations on this cell
			//for (var i = 1; i <= buckets; i++) {
			//	var cls = 'q' + i + '-' + buckets;
			//	d3.select(sel).classed(cls , false);
			//}
			
			// set new bucket designation for this cell
			var cls = data.tests[test].tiles[d][h]['test'];
			//console.log("sel=" + sel + " cls=" + cls);
			
			d3.select(sel).classed(cls, true);
		}
	}

	flipTiles();
	
	//if (isOldBrowser() === false) {
	//	drawHourlyChart(state, 3);
	//}
	
	//console.log("Finish");
}


function flipTiles() {

	var oldSide = d3.select('#tiles').attr('class'),
		newSide = '';

	//console.log("filpTiles");
	
	if (oldSide == 'front') {
		newSide = 'back';
	} else {
		newSide = 'front';
	}
	
	var flipper = function(h, d, side) {
		return function() {
			var sel = '#d' + d + 'h' + h + ' .tile',
				rotateY = 'rotateY(180deg)';
			
			if (side === 'back') {
				rotateY = 'rotateY(0deg)';	
			}
			/*
			if (browser.browser === 'Safari' || browser.browser === 'Chrome') {
				d3.select(sel).style('-webkit-transform', rotateY);
			} else {
				d3.select(sel).select('.' + oldSide).classed('hidden', true);
				d3.select(sel).select('.' + newSide).classed('hidden', false);
			}*/
			d3.select(sel).select('.' + oldSide).classed('hidden', true);
			d3.select(sel).select('.' + newSide).classed('hidden', false);
		};
	};

	for (var h = 0; h < columns.length; h++) {
		for (var d = 0; d < rows.length; d++) {
			var side = d3.select('#tiles').attr('class');
			setTimeout(flipper(h, d, side), (h * 20) + (d * 20) + (Math.random() * 100));
		}
	}
	d3.select('#tiles').attr('class', newSide);
}
