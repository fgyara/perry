var PerryGlobals = {
    perryTemplateTag: "data-perry-template",
    perryDataTag: "data-perry-data"
};

function renderTemplate(holder) {
    var compiledTemplate = Handlebars.compile(holder.templateValue);
    var html    = compiledTemplate(holder.dataValue);
    console.log(html);
    holder.div.replaceWith(html);
}

var onDataLoaded = function(holder, populate, data) {
    if (populate === "template") {
        holder.templateValue = data;
    }

    if (populate === "data") {
        holder.dataValue = data;
    }

    console.log( "Data received for " + holder.div.attr("id") + " - " + populate );

    if ((holder.templateValue !== "") & (holder.dataValue !== "") & (!holder.latch)) {
        holder.latch = true;
        renderTemplate(holder);
    }
};

function getRemoteAssets( holder) {

    var boundOnDataLoaded = onDataLoaded.bind(this, holder, "template");
    
    if (holder.templateUrl !== undefined) {
        $.ajax({
            url: holder.templateUrl,
            type: 'get',
            async: true,
            cache: false
        }).done( boundOnDataLoaded);
        console.log(holder.id + ": Requested template " + holder.templateUrl);
    }

    var boundDataFn = onDataLoaded.bind(this, holder, "data");
    $.ajax({
        url: holder.dataUrl,
        type: 'get',
        async: true,
        cache: false
    }).done( boundDataFn);
    console.log(holder.id + ": Requested data " + holder.dataUrl);

}    

var doesntDoMuch = function() {
    var didSomething = false;
    
    $('div[' + PerryGlobals.perryDataTag + ']').each( function(index) {
        var didSomething = true;
        
        var holder = { 
            id: index, 
            templateUrl: "", 
            dataUrl: "", 
            div: $(this), 
            templateValue: "", 
            dataValue: "",
            latch: false
        };

        // get the template
        holder.templateUrl = $(this).attr(PerryGlobals.perryTemplateTag);
        console.log( holder.id + ": template Url: "  + holder.templateUrl);
        
        if (holder.templateUrl === undefined) {
            console.log( "id:" + $(this).attr("id") + ": using template div");
            // use the html body as the template
            holder.templateValue = $(this).html();
            console.log(holder.templateValue);
        }
        
        // get the data
        holder.dataUrl = $(this).attr(PerryGlobals.perryDataTag);

        getRemoteAssets( holder);
    });
    
    return didSomething;
};

// loop through divs that are ajax and ensure that they are dynamically loaded
$(document).ready( doesntDoMuch);
