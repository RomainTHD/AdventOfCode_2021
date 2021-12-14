let funcs = [];

/**
 * Register a function
 * @param {(polymer:string, pairs:Pair[]) => number} f Function to register
 * @param {string} id Selector to register function to
 */
function register(f, id) {
    funcs.push({
        f, id,
    });
}

/**
 * Pair object
 */
class Pair {
    /**
     * @type {string}
     */
    pair;

    /**
     * @type {string}
     */
    insert;

    /**
     * @param {string} pair
     * @param {string} insert
     */
    constructor(pair, insert) {
        this.pair = pair;
        this.insert = insert;
    }
}

/**
 * Main
 * @param evt {Event} File submit event
 */
function main(evt) {
    let file = evt.target.files[0];
    let reader = new FileReader();

    reader.onload = (e) => {
        let result = e.target.result;
        let pairs = result.split("\n");
        let polymer = pairs[0];
        pairs.shift();

        let pairObjects = [];
        pairs.filter(p => p.length > 0).forEach((p) => {
            let pair = p.split(" -> ");
            pairObjects.push(new Pair(pair[0], pair[1]));
        });

        funcs.forEach((elt) => {
            document.querySelector(elt.id).innerText = elt.f(polymer, pairObjects);
        });

        document.querySelector("#ok").attributes.removeNamedItem("hidden");
    };

    reader.readAsText(file);
}

document.querySelector("#input").addEventListener("change", main, false);
