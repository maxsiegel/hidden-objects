
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

var video_scale = .7
for (var i = 0; i < mat_trials.length; i++) {
    timeline.push(
        {
            type: jsPsychVideoSliderResponse,
            stimulus: [mat_trials[i]],
            controls: true,
            choices: ["f", "j"],
            labels: ['Definitely Left', 'Don\'t Know' , 'Definitely Right'],
            require_movement: true,
            width: video_scale*1620,
            height: video_scale*1230,
            slider_width: 800,
            trial_ends_after_video: false,
            response_allowed_while_playing: true,
            prompt: "Which video, left or right, showed the same material as the top video? Please adjust the slider to indicate your relative confidence. <br><br>" // <br> (note: you can only do so after the video plays)

        }
    )
}

var shape_trials = jsPsych.randomization.shuffle(paths[group]['shape'])
for (var j = 0; j < shape_trials.length; j++) {

    timeline.push(
        {
            type: jsPsychVideoSliderResponse,
            stimulus: [shape_trials[j]],
            controls: true,
            width: video_scale * 1620,
            height: video_scale * 1230,
            slider_width: 800,
            prompt: "Which image (left or right) shows the invisible shape in the top video? Please adjust the above slider to indicate your relative confidence. <br><br>"
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
