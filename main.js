
var jsPsych = initJsPsych({'override_safe_mode' : true});

var group = jsPsych.randomization.shuffle([1, 2, 3])[0]

// var preload = {
//     type: jsPsychPreload,
//     video: 'videos/composite.mp4'
// }

var start = {
    type: jsPsychHtmlButtonResponse,
    stimulus: 'Which?',
    choices: ['Run Experiment']
};

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

var material_trial = function(path) {
    return {
        type: jsPsychVideoKeyboardResponse,
        stimulus: ['stimuli/' + path],
        controls: true,
        choices: ["f", "j"],
        trial_ends_after_video: false
    }
};

var trial_loop = {
    timeline: [trial, trial, show_data],
    loop_function: function() {
        return true;
    }
};

if (typeof jsPsych !== "undefined") {
    jsPsych.run([preload, start, trial_loop]);
} else {
    document.body.innerHTML = '<div style="text-align:center; margin-top:50%; transform:translate(0,-50%);">You must be online to view the plugin demo.</div>';
}
