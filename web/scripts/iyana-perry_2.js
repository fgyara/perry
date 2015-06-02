var PerryGlobals = {
    perryTemplateTag: "data-perry-template",
    perryDataTag: "data-perry-data"
};


var doesntDoMuch = function() {
    var body = $("body");
    processChildNodes(body, "");
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
    
    holder.node.replaceWith(htmlDiv);
    // see if they need any further replacements
    processChildNodes(htmlDiv, holder.id + ".");
}

// loop through divs that are ajax and ensure that they are dynamically loaded
$(document).ready( doesntDoMuch);
