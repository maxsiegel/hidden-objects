
var show_data = {
    type: jsPsychHtmlButtonResponse,
    stimulus: function() {
        // var trial_data = jsPsych.data.getLastTrialData().values();
        var data_json = JSON.stringify(jsPsych.data.allData, null, 2);
        return `<p style="margin-bottom:0px;"><strong>All Data:</strong></p>
        <pre style="margin-top:0px;text-align:left;">${data_json}</pre>`;
    },
    choices: ['Repeat demo']
};

function saveData(name, data) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'record_data.php');
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        filename: name,
        data: data
    }));
}
function createUID() {
    UID = "T" + Date.now() + "_K" + Math.floor((Math.random() * 100000000) + 1);
    return UID
}
