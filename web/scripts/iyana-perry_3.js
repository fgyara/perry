var PerryGlobals = {
    perryTemplateTag: "data-perry-template",
    perryDataTag: "data-perry-data",
    perryConfigTag: "data-perry-config"
};


var doesntDoMuch = function() {
    
    // register the hash change listener
    $(window).on('hashchange', onHashChanged);    
    
    var perryConfig = $("body[" + PerryGlobals.perryConfigTag + "]");
    
    if (perryConfig.length !== 0) {
        // we have a proper configuration file
        processPerryConfig(perryConfig.attr(PerryGlobals.perryConfigTag));
    } else {
        // no config file - see if we find any data-perry-* markup in the body
        var body = $("body");
        processChildNodes(body, "");
    }
    
};

function processPerryConfig(configUrl) {
    console.log("Perry config url: " + configUrl);
    //var boundOnConfigLoaded = onConfigLoaded.bind(this, this);
    
    $.ajax({
        url: configUrl,
        type: 'get',
        async: true,
        cache: false
    }).done( onConfigLoaded);
}

var onConfigLoaded = function(data) {
    console.log ( "Perry: config loaded");
    
    // find the location
    var loc = location.hash;
    if (loc === "") {
        loc = "#";
    }
    console.log ( "Perry: matching location: " + loc);
    
    // find a config
    var config = data.config[loc];
    console.log( "Perry: Configured template: " + config.template + " asset:" + config.data);
    
    // find the body tag
    var body = $("body");
    body.attr( PerryGlobals.perryDataTag, config.data);
    body.attr( PerryGlobals.perryTemplateTag, config.template);
    body.removeAttr( PerryGlobals.perryConfigTag);
    
    processNode(body, "C");
};

var onHashChanged = function() {
    alert("Hash changed");
};


function processChildNodes(node, consolePrefix) {
    
    var nodes = 0;
    node.filter('[' + PerryGlobals.perryTemplateTag + ']').each( function(index) {
        nodes++;
        console.log(consolePrefix + ": found node with id: " + $(this).attr("id"));
        processNode($(this), consolePrefix + nodes);
    });
    
    node.find('[' + PerryGlobals.perryTemplateTag + ']').each( function(index) {
        nodes++;
        console.log(consolePrefix + ": found child node with id: " + $(this).attr("id"));
        processNode($(this), consolePrefix + nodes);
    });
}

function processNode(node, itemId) {
    var holder = { 
        id: itemId, 
        templateUrl: "", 
        dataUrl: "", 
        node: node, 
        templateValue: "", 
        dataValue: "",
        dataRequired: false,
        latch: false
    };

    // get the template
    holder.templateUrl = node.attr(PerryGlobals.perryTemplateTag);
    console.log( holder.id + ": template Url: "  + holder.templateUrl);

    if (holder.templateUrl === undefined) {
        console.log( holder.id + ": template url is undefined. Stopping");
        return;
    }

    // get the data
    holder.dataUrl = node.attr(PerryGlobals.perryDataTag);
    console.log( holder.id + ": data Url: "  + holder.dataUrl);

    holder.dataRequired =  ((holder.dataUrl !== undefined) && (holder.dataUrl !== ""));
    console.log( holder.id + ": data required: "  + holder.dataRequired);
    
    getRemoteAssets( holder);
}

function getRemoteAssets( holder) {

    var boundTemplateFn = onDataLoaded.bind(this, holder, "template");
    $.ajax({
        url: holder.templateUrl,
        type: 'get',
        async: true,
        cache: false
    }).done( boundTemplateFn);

    if (holder.dataRequired ) {
        var boundDataFn = onDataLoaded.bind(this, holder, "data");
        $.ajax({
            url: holder.dataUrl,
            type: 'get',
            async: true,
            cache: false
        }).done( boundDataFn);
    }
}    


var onDataLoaded = function(holder, populate, data) {
    console.log ( holder.id + ": " + populate + " loaded");
    if (populate === "template") {
        holder.templateValue = data;
    }

    if (populate === "data") {
        holder.dataValue = data;
    }

    var templateReady = (holder.templateValue !== "");
    var dataReady = (!holder.dataRequired || (holder.dataValue !== ""));
    if (templateReady & dataReady & (!holder.latch)) {
        holder.latch = true;
        renderTemplate(holder);
    }
};

function renderTemplate(holder) {
    var htmlDiv;
    
    if (!holder.dataRequired) {
        console.log(holder.id + ": Rendering (no merge)");
        htmlDiv = $(holder.templateValue);
    } else {
        console.log(holder.id + ": Rendering");
        var compiledTemplate = Handlebars.compile(holder.templateValue);
        var html = compiledTemplate(holder.dataValue);

        // replace the contents
        htmlDiv = $(html);
    }
    
    console.log(holder.node.prop("tagName"));
    if (holder.node.prop("tagName") === "BODY") {
        holder.node.html(htmlDiv);
    } else {
        holder.node.replaceWith(htmlDiv);
    }
    
    // see if they need any further replacements
    processChildNodes(htmlDiv, holder.id + ".");
}

// loop through divs that are ajax and ensure that they are dynamically loaded
$(document).ready( doesntDoMuch);


