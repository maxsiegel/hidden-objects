
var jsPsych = initJsPsych({'override_safe_mode' : true,
                           on_trial_finish: function() {
                           }
});

var group_num = jsPsych.randomization.shuffle([1, 2, 3])[0]
var group = 'Group' + group_num
jsPsych.data.addProperties({'group': group_num})
// var preload = {
//     type: jsPsychPreload,
//     video: 'videos/composite.mp4'
// }


timeline = []

var mat_trials = jsPsych.randomization.shuffle(paths[group]['material'])

var video_scale = .7

// part 1
timeline.push(
    {type: jsPsychHtmlButtonResponse,
     stimulus: "This experiment consists of two parts: a first part with 4 trials and a second part with 8 trials.. <br><br>First, we will do part 1. On each trial, you will see three videos, one after the other.<br><br>The videos show materials of various kinds — liquids, particles, squishy or bouncy things — moving and interacting with other objects of various shapes.  <br><br>Your task is to decide whether the material that you have seen in the upper video is more similar to the material in the left or right video at the bottom. <br><br> To give your response, please adjust the slider you will see, using your mouse.",
     // .<br><br>An example will follow.
     choices: ['Continue']}
)

// timeline.push(
//     {type: jsPsychVideoButtonResponse,
//      stimulus: ["instructions/test.mp4"],
//      width: video_scale * 1620,
//      height: video_scale * 1230,
//      choices: ['Continue'],
//      response_allowed_while_playing: true}
// )

timeline.push(
    {type: jsPsychHtmlButtonResponse,
     stimulus: "Your job is to decide whether the material that you see in the upper video is more similar to the material in the left or the right video at the bottom. To give your response, please adjust the slider, pictured below, using your mouse.<br><br><br><br><img src=\"instructions/slider.png\" width=\"75%\"><br><br><br>The more certain you are that it is the material on the left, the further left you should set the slider. <br>The more certain you are that it is the material on the right, the further right you should set the slider. <br><br><br>You can replay the videos by pressing the play button at the bottom left of the video. In order to respond and continue, you must watch the videos at least once.<br>We will start with a practice round. ",
     choices: ['Continue']}
)

timeline.push(
    {
        type: jsPsychVideoSliderResponse,
        stimulus: ['instructions/demo.mp4'],
        controls: true,
        labels: ['Definitely Left', 'Don\'t Know' , 'Definitely Right'],
        require_movement: true,
        width: video_scale*1620,
        height: video_scale*1230,
        slider_width: 800,
        trial_ends_after_video: false,
        response_allowed_while_playing: true,
        prompt: "(Practice)<br>Which video, left or right, showed the same material as the top video? Please adjust the slider to indicate your relative confidence. <br><br>" // <br> (note: you can only do so after the video plays)
    }
)


timeline.push(
    {type: jsPsychHtmlButtonResponse,
     stimulus: "Now it's time to begin part 1 of the experiment.",
     choices: ['Begin']}
)

// for (var i = 0; i < mat_trials.length; i++) {
for (var i = 0; i < 1; i++) {
    timeline.push(
        {
            type: jsPsychVideoSliderResponse,
            stimulus: [mat_trials[i]],
            controls: true,
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

timeline.push(
    {type: jsPsychHtmlButtonResponse,
     stimulus: "Great job! It\'s time for part 2. <br><br>Now, you will see more videos, similar to those you\'ve already seen. You may have noticed that each of these videos appears to contain an object that is present in the scene but is not directly visible. Your job is to identify the shape of that invisible object. <br><br>After each video stops, two images will appear below the video. Please adjust the slider using your mouse to indicate which of these shapes corresponds to the invisible object in the top video. <br><br>The more certain you are that it is the shape on the left, the further left you should set the slider. <br><br>The more certain you are that it is the shape on the right, the further right you should set the slider. You can replay the videos by pressing the ‘play’ button.<br><br> We will start with a practice round.",
     choices: ['Continue']}
)

timeline.push(
    {
        type: jsPsychVideoSliderResponse,
        stimulus: ['instructions/demo2.mp4'],
        controls: true,
        labels: ['Definitely Left', 'Don\'t Know' , 'Definitely Right'],
        require_movement: true,
        width: video_scale*1620,
        height: video_scale*1230,
        slider_width: 800,
        trial_ends_after_video: false,
        response_allowed_while_playing: true,
        prompt: "(Practice)<br>Which video, left or right, showed the same shape as the top video? Please adjust the slider to indicate your relative confidence. <br><br>Click the button to begin part 2.", // <br> (note: you can only do so after the video plays)
        button_label: "Begin"
    }
)



var shape_trials = jsPsych.randomization.shuffle(paths[group]['shape'])
// for (var j = 0; j < shape_trials.length; j++) {
for (var j = 0; j < 1; j++) {

    timeline.push(
        {
            type: jsPsychVideoSliderResponse,
            stimulus: [shape_trials[j]],
            controls: true,
            labels: ['Definitely Left', 'Don\'t Know' , 'Definitely Right'],
            width: video_scale * 1620,
            height: video_scale * 1230,
            slider_width: 800,
            prompt: "Which image (left or right) shows the invisible shape in the top video? Please adjust the above slider to indicate your relative confidence. <br><br>",
            response_allowed_while_playing: true,

        }
    )
}

var debrief = {

    type: jsPsychSurveyHtmlForm,
    html: '<p>Did you enjoy this experiment? &nbsp&nbsp&nbsp<textarea name="enjoy" rows="5" cols="50"></textarea></p><br><br><br><p>Were you aware of using any conscious or deliberate strategy in making the judgments that you did?&nbsp&nbsp&nbsp<textarea name="strategy" rows="5" cols="50"></textarea></p><br><br><br>Any other comments?&nbsp&nbsp&nbsp<textarea name="comments" rows="5" cols="50"></textarea><br><br><br>Please enter your Prolific ID.&nbsp&nbsp<input size = 15 name="prolific"></input>',
    // button_label: 'Return',
    on_finish: function() {
        saveData(createUID(), jsPsych.data.get().csv());
    }
}
timeline.push(debrief)

var done = {
    type: jsPsychHtmlButtonResponse,
    stimulus: "<b>Click the button below to submit and return to Prolific.<br><br></b>",
    choices: ["Return"],
    on_finish: function() {
        location.href = "http://www.google.com"
    }
}
timeline.push(done)

jsPsych.run(// preload,
    timeline// , trial_loop
);
