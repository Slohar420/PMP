var gfeedfetcher_loading_image="loading.gif" //Specify full URL to "loading" image. Overwrites same var from gfeedfetcher.js


function gfeedpausescroller(divid, divClass, delay, linktarget){
	this.tickerid=divid //ID of outermost scroller div
	this.delay=parseInt(delay) //Default delay between msg change, in miliseconds.
	this.mouseoverBol=0 //Boolean to indicate whether mouse is currently over scroller (and pause it if it is)
	this.hiddendivpointer=1 //index of RSS feed array's entry for hidden div
	this.itemsperpage=1 //Entries to show per page
	document.write('<div id="'+divid+'" class="'+divClass+'" style="position: relative; overflow: hidden">')
	document.write('<div class="innerDiv" style="position: absolute; width: 100%" id="'+divid+'1"><span style="position: absolute">Initializing RSS scroller...</span></div>')
	document.write('<div class="innerDiv" style="position: absolute; width: 100%; visibility: hidden" id="'+divid+'2"></div>')
	gfeedfetcher.call(this, divid+"unneeded", divClass+"unneeded", linktarget) //inherit properties from "gfeedfetcher" class, but feed it bogus ID/Class, as we won't be using the DIV generated by "gfeedfetcher"
	document.write('</div>')
	this.itemcontainer="<div>" //default element wrapping around each RSS entry
	this.feedcontainer.style.display="none" //Hide unneeded div generated after inheriting properties from "gfeedfetcher" class
	this.feedcontainer=document.getElementById(divid+'1') //overwrite inherited "feedcontainer" to reference the first DIV within scroller container
	this.tickerdiv=document.getElementById(divid)
	this.visiblediv=document.getElementById(divid+"1")
	this.hiddendiv=document.getElementById(divid+"2")
	this.visibledivtop=parseInt(this.tickerdiv.currentStyle? this.tickerdiv.currentStyle["paddingTop"] : window.getComputedStyle? window.getComputedStyle(this.tickerdiv, "").getPropertyValue("padding-top") : 0) //Determine the "top" boundary of the visible div, factoring in any CSS padding
	this.tickerdivwidth=this.tickerdiv.currentStyle? parseInt(this.tickerdiv.currentStyle["width"]) : this.tickerdiv.offsetWidth //IE has trouble getting offsetWidth while page is loading, so use global CSS value instead
	this.tickerdivheight=this.tickerdiv.currentStyle? parseInt(this.tickerdiv.currentStyle["height"])+50 : 0 //IE has trouble getting offsetWidth while page is loading, so use global CSS value instead. "50" accounts for any possible padding skewing things. Variable used by any other browser.
}

gfeedpausescroller.prototype=new gfeedfetcher //inherit methods from gfeedfetcher class
gfeedpausescroller.prototype.constructor=gfeedpausescroller
gfeedpausescroller.prototype._displayresult=null //Remove inherited method "_displayresult()"


// -------------------------------------------------------------------
// entries_per_page()- Sets the number of RSS entries to display per page (at once)
// -------------------------------------------------------------------

gfeedpausescroller.prototype.entries_per_page=function(num){
	this.itemsperpage=num
}

// -------------------------------------------------------------------
// _signaldownloadcomplete()- Signals to the rest of the script when the fetching of all RSS feeds is complete
// -------------------------------------------------------------------

gfeedpausescroller.prototype._signaldownloadcomplete=function(){ //overwrite inherited method "_signaldownloadcomplete()"
	this.feedsfetched+=1
	if (this.feedsfetched==this.feedurls.length) //if all feeds fetched
		this._populateticker(this.feeds) //Populate the two DIVs within scroller with the fetched data
}

// -------------------------------------------------------------------
// _populateticker()- Pre-populates the two DIVs of the scroller with the 1st and 2nd RSS entries.
// -------------------------------------------------------------------

gfeedpausescroller.prototype._populateticker=function(feeds){
	gfeedfetcher._sortarray(feeds, this.sortstring)
	//set width of inner DIVs to outer DIV's width minus padding (padding assumed to be top padding x 2)
	this.visiblediv.style.width=this.hiddendiv.style.width=parseInt(this.tickerdivwidth)-(this.visibledivtop*2)+"px"
	this.itemsperpage=(this.itemsperpage>=feeds.length)? 1 : this.itemsperpage //Adjust "itemsperpage" if needed (based on total # of avail entries)
	var feedslice1=feeds.slice(0, this.itemsperpage) //Get subsection of feed array based on how many entries to show at once
	this.hiddendivpointer=this.itemsperpage //Set the feed array index of the hidden div accordingly
	var feedslice2=feeds.slice(this.hiddendivpointer, this.hiddendivpointer+this.itemsperpage)
	this.visiblediv.innerHTML=formatrssmessage(feedslice1, this.showoptions, this.itemcontainer, this.linktarget, this.lengthlimits, this.regexprules)
	this.hiddendiv.innerHTML=formatrssmessage(feedslice2, this.showoptions, this.itemcontainer, this.linktarget, this.lengthlimits, this.regexprules)
	this._initscroller()
}


// -------------------------------------------------------------------
// _initscroller()- Initialize the scroller by setting initial positions of the two dinner DIVs, start up down animation
// -------------------------------------------------------------------

gfeedpausescroller.prototype._initscroller=function(){
	var scrollerinstance=this
	this.getinline(this.visiblediv, this.hiddendiv)
	this.hiddendiv.style.visibility="visible"
	//set width of inner DIVs to outer DIV's width minus padding (padding assumed to be top padding x 2)
	this.visiblediv.style.width=this.hiddendiv.style.width=parseInt(this.tickerdivwidth)-(this.visibledivtop*2)+"px"
	this.tickerdiv.onmouseover=function(){scrollerinstance.mouseoverBol=1}
	this.tickerdiv.onmouseout=function(){scrollerinstance.mouseoverBol=0}
	if (window.attachEvent) //Clean up loose references in IE
		window.attachEvent("onunload", function(){scrollerinstance.tickerdiv.onmouseover=scrollerinstance.tickerdiv.onmouseout=null})
	setTimeout(function(){scrollerinstance._animateup()}, this.delay)
}

// -------------------------------------------------------------------
// formatrssmessage()- Global function that formats a RSS entry(s) to the desired components (title, date, description etc)
// -------------------------------------------------------------------

function formatrssmessage(feedslice, showoptions, itemcontainer, linktarget, lengthlimits, regexes){

	var limitchars = gfeedfetcher.limitchars || function(t){return t;}, rgtitle = regexes.titlefield, rgdesc = regexes.descriptionfield,
	hr = gfeedfetcher.handleregexes || function(t){return t;};

	var rssoutput=(itemcontainer=="<li>")? "<ul>\n" : "" //if "itemcontainer" is set to "<li>", define a "<ul>" tag to wrap around the result
	for (var i=0; i<feedslice.length; i++){ //Loop through the entered slice of a RSS feed (1 or more entries)
		var itemtitle = limitchars(hr(feedslice[i].dditemtitle || feedslice[i].title, rgtitle), lengthlimits['titlefield']),
		link = gfeedfetcher.bestlink? gfeedfetcher.bestlink(feedslice[i]) : feedslice[i].link;
		itemtitle='<a href="' + link + '" target="' + linktarget + '" class="titlefield">' + itemtitle + '</a>';
		var itemlabel=/label/i.test(showoptions)? '<span class="labelfield">['+feedslice[i].ddlabel+']</span>' : " "
		var itemdate = hr(gfeedfetcher._formatdate((feedslice[i].ddpublishedDate || feedslice[i].publishedDate), showoptions), regexes.datefield);
		var itemdescription = "";
		if(/description|snippet/i.test(showoptions)){
			itemdescription = hr(feedslice[i].description || (gfeedfetcher.atomdesc? gfeedfetcher.atomdesc(feedslice[i]) : ""), rgdesc);
			itemdescription = '<br />' + limitchars(itemdescription, lengthlimits['descriptionfield']);
		}
		rssoutput+=itemcontainer + itemtitle + " " + itemlabel + " " + itemdate + "\n" + itemdescription + itemcontainer.replace("<", "</") + "\n\n"
	}
	rssoutput+=(itemcontainer=="<li>")? "</ul>\n" : ""
	return hr(rssoutput, regexes.all);
}


// -------------------------------------------------------------------
// _animateup()- Move the two inner divs of the scroller up and in sync
// -------------------------------------------------------------------

gfeedpausescroller.prototype._animateup=function(){
	var scrollerinstance=this
	if (this.mouseoverBol==1) //if mouse is currently over scoller, do nothing (pause it)
			return setTimeout(function(){scrollerinstance._animateup()}, 100)
		if (parseInt(this.hiddendiv.style.top)>(this.visibledivtop+5)){
		this.visiblediv.style.top=parseInt(this.visiblediv.style.top)-5+"px"
		this.hiddendiv.style.top=parseInt(this.hiddendiv.style.top)-5+"px"
		setTimeout(function(){scrollerinstance._animateup()}, 40)
	}
	else{
		this.getinline(this.hiddendiv, this.visiblediv)
		this._swapdivs()
		setTimeout(function(){scrollerinstance._rotatemessage()}, this.delay)
	}
}


// -------------------------------------------------------------------
// _swapdivs()- Swap between which is the visible and which is the hidden div
// -------------------------------------------------------------------

gfeedpausescroller.prototype._swapdivs=function(){
	var tempcontainer=this.visiblediv
	this.visiblediv=this.hiddendiv
	this.hiddendiv=tempcontainer
}

gfeedpausescroller.prototype.getinline=function(div1, div2){
	div1.style.top=this.visibledivtop+"px"
	div2.style.top=Math.max(div1.parentNode.offsetHeight || this.tickerdivheight, div1.offsetHeight)+"px"
}


// -------------------------------------------------------------------
// _rotatemessage()- Populate the hidden div with the next message before it's visible
// -------------------------------------------------------------------

gfeedpausescroller.prototype._rotatemessage=function(){
	var scrollerinstance=this
	if (this.mouseoverBol==1) //if mouse is currently over scoller, do nothing (pause it)
		setTimeout(function(){scrollerinstance._rotatemessage()}, 100)
	else{
		var i=this.hiddendivpointer
		var ceiling=this.feeds.length
		this.hiddendivpointer=(i+this.itemsperpage>ceiling-1)? 0 : i+this.itemsperpage
		var feedslice=this.feeds.slice(this.hiddendivpointer, this.hiddendivpointer+this.itemsperpage)
		this.hiddendiv.innerHTML=formatrssmessage(feedslice, this.showoptions, this.itemcontainer, this.linktarget, this.lengthlimits, this.regexprules)
		this._animateup()
	}
}