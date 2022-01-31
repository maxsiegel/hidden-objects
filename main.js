
var jsPsych = initJsPsych({'override_safe_mode' : true});

var group_num = jsPsych.randomization.shuffle([1, 2, 3])[0]
var group = 'Group' + group_num

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

timeline = []

var mat_trials = jsPsych.randomization.shuffle(paths[group]['material'])
for (var i = 0; i < mat_trials.length; i++) {
    timeline.push(
        {
            type: jsPsychVideoKeyboardResponse,
            stimulus: [mat_trials[i]],
            controls: true,
            choices: ["f", "j"],
            width: 1024,
            height: 768,
            trial_ends_after_video: false
        }
    )
}

var shape_trials = jsPsych.randomization.shuffle(paths[group]['shape'])
for (var j = 0; j < shape_trials.length; j++) {
    timeline.push(
        {
            type: jsPsychVideoKeyboardResponse,
            stimulus: [shape_trials[j][0]],
            controls: true,
            choices: ["f", "j"],
            prompt: "<img src=" + shape_trials[j][1] + " height='25%' width='25%'><img src=" + shape_trials[j][2] + " height='25%' width='25%'>"
            // prompt: "test"
        }
    )
}
// var trial_loop = {
//     timeline: [trial, trial, show_data],
//     loop_function: function() {
//         return true;
//     }
// };

jsPsych.run(// preload,
    timeline// , trial_loop
);
