// A $( document ).ready() block.
$( document ).ready(function() {
    
    const timeline = document.getElementById("timeline")

    timeline.addEventListener("click", (e) => {

        // Timevis Balken 
        if(e.target.classList.contains("vis-item-overflow")) {
            Shiny.onInputChange("timelineval", e.target.childNodes[0].innerHTML);

        // Timevis Schrift
        } else if (e.target.classList.contains("vis-item-content")) {
            Shiny.onInputChange("timelineval", e.target.innerHTML);
        }
    })
});